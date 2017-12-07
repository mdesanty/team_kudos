class Api::V1::KudosController < ActionController::API
  # include ActionController::MimeResponds

  def challenge
    render json: params[:challenge]
  end

  def event
    # Parameters: {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"words", "ts"=>"1512329312.000087", "channel"=>"G88E53QJV", "event_ts"=>"1512329312.000087"}, "type"=>"event_callback", "event_id"=>"Ev89RMRABG", "event_time"=>1512329312, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"words", "ts"=>"1512329312.000087", "channel"=>"G88E53QJV", "event_ts"=>"1512329312.000087"}, "type"=>"event_callback", "event_id"=>"Ev89RMRABG", "event_time"=>1512329312, "authed_users"=>["U0QG8DQUF"]}}

    @text = params[:text]
    @is_kudo = @test.match(/\:thumbsup\:/).present?

    if @is_kudo
      to_user_slack_identifier = ParseToSlackUserIdentifierFromMessageService.execute(message)
      CreateKudoService.execute({slack_identifier: params[:team_id]}, {slack_identifier: params[:user]}, {slack_identifier: to_user_slack_identifier}, params[:text])
    end

    render json: params[:challenge]
  end
end