class Api::V1::KudosController < ActionController::API
  # include ActionController::MimeResponds

  def challenge
    render json: params[:challenge]
  end

  def event
    # Parameters with emoji and to user:
    # Parameters: {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Here are some kudos for <@U18DA41HD> :thumbsup:", "ts"=>"1512610950.000137", "channel"=>"G88E53QJV", "event_ts"=>"1512610950.000137"}, "type"=>"event_callback", "event_id"=>"Ev8ATQ9K1Q", "event_time"=>1512610950, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Here are some kudos for <@U18DA41HD> :thumbsup:", "ts"=>"1512610950.000137", "channel"=>"G88E53QJV", "event_ts"=>"1512610950.000137"}, "type"=>"event_callback", "event_id"=>"Ev8ATQ9K1Q", "event_time"=>1512610950, "authed_users"=>["U0QG8DQUF"]}}

    # Parameters with emoji but no to user:
    # Parameters: {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudoes for nobody :thumbsup:", "ts"=>"1512611086.000123", "channel"=>"G88E53QJV", "event_ts"=>"1512611086.000123"}, "type"=>"event_callback", "event_id"=>"Ev8BPY613Q", "event_time"=>1512611086, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudoes for nobody :thumbsup:", "ts"=>"1512611086.000123", "channel"=>"G88E53QJV", "event_ts"=>"1512611086.000123"}, "type"=>"event_callback", "event_id"=>"Ev8BPY613Q", "event_time"=>1512611086, "authed_users"=>["U0QG8DQUF"]}}

    # Parameters with no emoji:
    # Parameters: {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudos for <@U18DA41HD>", "ts"=>"1512611129.000116", "channel"=>"G88E53QJV", "event_ts"=>"1512611129.000116"}, "type"=>"event_callback", "event_id"=>"Ev8ARKP6LT", "event_time"=>1512611129, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudos for <@U18DA41HD>", "ts"=>"1512611129.000116", "channel"=>"G88E53QJV", "event_ts"=>"1512611129.000116"}, "type"=>"event_callback", "event_id"=>"Ev8ARKP6LT", "event_time"=>1512611129, "authed_users"=>["U0QG8DQUF"]}}

    CreateKudoFromRequestService.execute(params)
    render json: params[:challenge]
  end

  def install
    access_response = SlackApiInterface.oauth_access(params['code'])
    logger.info(access_response.inspect)
  end
end