require 'test_helper'

class CreateKudoServiceTest < ActiveSupport::TestCase
  test 'execute should create kudo' do
    from_slack_user_data = {email: 'michael@gmail.com'}
    to_slack_user_data = {email: 'steven@gmail.com'}
    message = '@steven gets :kudo: for something awesome'

    assert_difference('Kudo.count', 1) do
      assert_difference('SlackUser.count', 2) do
        @kudo = CreateKudoService.execute(from_slack_user_data, to_slack_user_data, message)
      end
    end

    expected_from_slack_user_id = SlackUser.find_by_email('michael@gmail.com').id
    expected_to_slack_user_id = SlackUser.find_by_email('steven@gmail.com').id
    expected_message = '@steven gets :kudo: for something awesome'

    assert_equal(expected_from_slack_user_id, @kudo.from_slack_user_id)
    assert_equal(expected_to_slack_user_id, @kudo.to_slack_user_id)
    assert_equal(expected_message, @kudo.message)
  end
end