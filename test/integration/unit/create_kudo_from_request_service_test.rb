require 'test_helper'

class CreateKudoFromRequestServiceTest < ActiveSupport::TestCase
  setup do
    @service = CreateKudoFromRequestService
  end

  test 'execute should create kudo from request parameters' do
    parameters = {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Here are some kudos for <@U18DA41HD> :thumbsup:", "ts"=>"1512610950.000137", "channel"=>"G88E53QJV", "event_ts"=>"1512610950.000137"}, "type"=>"event_callback", "event_id"=>"Ev8ATQ9K1Q", "event_time"=>1512610950, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Here are some kudos for <@U18DA41HD> :thumbsup:", "ts"=>"1512610950.000137", "channel"=>"G88E53QJV", "event_ts"=>"1512610950.000137"}, "type"=>"event_callback", "event_id"=>"Ev8ATQ9K1Q", "event_time"=>1512610950, "authed_users"=>["U0QG8DQUF"]}}

    assert_difference(['Kudo.count', 'SlackTeam.count'], 1) do
      assert_difference('SlackUser.count', 2) do
        @kudo = @service.execute(parameters)
      end
    end

    expected_slack_team_id = SlackTeam.find_by_slack_identifier('T0QGA5E0Z').id
    expected_from_slack_user_id = SlackUser.find_by_slack_identifier('U0QG8DQUF').id
    expected_to_slack_user_id = SlackUser.find_by_slack_identifier('U18DA41HD').id

    assert_equal(expected_slack_team_id, @kudo.slack_team.id)

    assert_equal(expected_from_slack_user_id, @kudo.from_slack_user_id)
    assert_equal(expected_slack_team_id, @kudo.from_slack_user.slack_team_id)

    assert_equal(expected_to_slack_user_id, @kudo.to_slack_user_id)
    assert_equal(expected_slack_team_id, @kudo.to_slack_user.slack_team_id)

    assert_equal("Here are some kudos for <@U18DA41HD> :thumbsup:", @kudo.message)
  end

  test 'execute should not create kudo when to user is not provided' do
    parameters = {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudoes for nobody :thumbsup:", "ts"=>"1512611086.000123", "channel"=>"G88E53QJV", "event_ts"=>"1512611086.000123"}, "type"=>"event_callback", "event_id"=>"Ev8BPY613Q", "event_time"=>1512611086, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudoes for nobody :thumbsup:", "ts"=>"1512611086.000123", "channel"=>"G88E53QJV", "event_ts"=>"1512611086.000123"}, "type"=>"event_callback", "event_id"=>"Ev8BPY613Q", "event_time"=>1512611086, "authed_users"=>["U0QG8DQUF"]}}

    assert_difference(['Kudo.count', 'SlackTeam.count', 'SlackUser.count'], 0) do
      @kudo = @service.execute(parameters)
    end
  end

  test 'execute should not create kudo when emoji is not provided' do
    parameters = {"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudos for <@U18DA41HD>", "ts"=>"1512611129.000116", "channel"=>"G88E53QJV", "event_ts"=>"1512611129.000116"}, "type"=>"event_callback", "event_id"=>"Ev8ARKP6LT", "event_time"=>1512611129, "authed_users"=>["U0QG8DQUF"], "kudo"=>{"token"=>"aOiKX5h7VtDa1i1gLiXujpAK", "team_id"=>"T0QGA5E0Z", "api_app_id"=>"A88T1SMMJ", "event"=>{"type"=>"message", "user"=>"U0QG8DQUF", "text"=>"Kudos for <@U18DA41HD>", "ts"=>"1512611129.000116", "channel"=>"G88E53QJV", "event_ts"=>"1512611129.000116"}, "type"=>"event_callback", "event_id"=>"Ev8ARKP6LT", "event_time"=>1512611129, "authed_users"=>["U0QG8DQUF"]}}

    assert_difference(['Kudo.count', 'SlackTeam.count', 'SlackUser.count'], 0) do
      @kudo = @service.execute(parameters)
    end
  end
end