class CreateKudoFromRequestService
  def self.execute(params)
    return new.execute(params)
  end

  def execute(params)
    initialize_variables
    @params = params

    if request_is_kudo?
      CreateKudoService.execute(*service_parameters)
    end
  end

  private

  def initialize_variables
    @params = nil
  end

  def request_is_kudo?
    return (request_contains_kudo_emoji? && request_contains_to_user?)
  end

  def request_contains_kudo_emoji?
    return message_text.match(/\:thumbsup\:/).present?
  end

  def message_text
    return @message_text ||= @params['event']['text']
  end

  def request_contains_to_user?
    return to_slack_user_identifier.present?
  end

  def to_slack_user_identifier
    return @to_slack_user_identifier ||= ParseToSlackUserIdentifierFromMessageService.execute(message_text)
  end

  def service_parameters
    parameters =
    [
      prepared_message_text,
      {
        slack_team_identifier: slack_team_identifier,
        from_slack_user_identifier: from_slack_user_identifier,
        to_slack_user_identifier: to_slack_user_identifier
      }
    ]
  end

  def prepared_message_text
    return @prepared_message_text ||= message_text
  end

  def slack_team_identifier
    return @slack_team_identifier ||= @params['team_id']
  end

  def from_slack_user_identifier
    return @from_slack_user_identifier ||= @params['event']['user']
  end
end