require 'test_helper'

class ParseToSlackUserIdentifierFromMessageServiceTest < ActiveSupport::TestCase
  test 'execute should parse to slack user identifier from message' do
    message = '<@U18DA41HD> what up <@U18DA51HH>'
    assert_equal('U18DA41HD', ParseToSlackUserIdentifierFromMessageService.execute(message))
  end
end