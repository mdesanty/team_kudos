require 'test_helper'

class CreateKudoServiceTest < ActiveSupport::TestCase
  test 'execute should create kudo' do
    slack_team_identifier = '12345K'
    from_slack_user_identifier = '123A'
    to_slack_user_identifier = '123B'
    message = '@steven gets :kudo: for something awesome'

    assert_difference(['Kudo.count', 'SlackTeam.count'], 1) do
      assert_difference('SlackUser.count', 2) do
        @kudo = CreateKudoService.execute(message, {slack_team_identifier: slack_team_identifier, from_slack_user_identifier: from_slack_user_identifier, to_slack_user_identifier: to_slack_user_identifier})
      end
    end

    expected_slack_team_id = SlackTeam.find_by_slack_identifier('12345K').id
    expected_from_slack_user_id = SlackUser.find_by_slack_identifier('123A').id
    expected_to_slack_user_id = SlackUser.find_by_slack_identifier('123B').id
    expected_message = '@steven gets :kudo: for something awesome'

    assert_equal(expected_slack_team_id, @kudo.slack_team.id)

    assert_equal(expected_from_slack_user_id, @kudo.from_slack_user_id)
    assert_equal(expected_slack_team_id, @kudo.from_slack_user.slack_team_id)

    assert_equal(expected_to_slack_user_id, @kudo.to_slack_user_id)
    assert_equal(expected_slack_team_id, @kudo.to_slack_user.slack_team_id)

    assert_equal(expected_message, @kudo.message)
  end
end