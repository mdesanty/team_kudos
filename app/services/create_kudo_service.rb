class CreateKudoService
  def self.execute(from_slack_user_data, to_slack_user_data, message)
    return new.execute(from_slack_user_data, to_slack_user_data, message)
  end

  def execute(from_slack_user_data, to_slack_user_data, message)
    initialize_variables

    @from_slack_user_data = from_slack_user_data
    @to_slack_user_data = to_slack_user_data
    @message = message

    return create_kudo
  end

  private

  def initialize_variables
    @from_slakc_user_data = nil
    @to_slack_user_data = nil
    @message = nil
  end

  def create_kudo
    return Kudo.create(from_slack_user: from_slack_user, to_slack_user: to_slack_user, message: @message)
  end

  def from_slack_user
    return @from_slack_user ||= SlackUser.where(email: @from_slack_user_data[:email]).first_or_create
  end

  def to_slack_user
    return @to_slack_user ||= SlackUser.where(email: @to_slack_user_data[:email]).first_or_create
  end
end