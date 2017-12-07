class ParseToSlackUserIdentifierFromMessageService
  def self.execute(message)
    user_string = message[/.*?\<@([a-zA-Z0-9]+?)\>.*/, 1]
    return user_string
  end
end