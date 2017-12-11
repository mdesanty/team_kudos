require 'httparty'

class SlackApiInterface
  include HTTParty

  CLIENT_ID = '24554184033.280919905732'
  CLIENT_SECRET = 'ddf82fd8b9d6fb7dcaf3b08b18dae180'
  REDIRECT_URL = 'http://www.google.com'

  # Need to store this per team. Have to figure out the install and callback process.
  APPLICATION_TOKEN = 'xoxp-24554184033-24552466967-281868709718-84c21562477d278a698aa6e5a6d0685e'
  #APPLICATION_TOKEN = 'xoxb-280923287235-mBxm60wLGhuh2yNcdQ0o036E'
  USER_INFO_ENDPOINT = 'https://slack.com/api/users.info'
  TEAM_INFO_ENDPOINT = 'https://slack.com/api/team.info'
  OAUTH_ACCESS_ENDOINT = 'https://slack.com/api/oauth.access'

  def self.user_info(slack_user_identifier)
    response = post(USER_INFO_ENDPOINT, body: {token: APPLICATION_TOKEN, user: slack_user_identifier})
    return JSON.parse(response.body)
  end

  def self.team_info()
    response = post(TEAM_INFO_ENDPOINT, body: {token: APPLICATION_TOKEN})
    return JSON.parse(response.body)
  end

  def self.oauth_access(code)
    response = post(OAUTH_ACCESS_ENDOINT, body: {client_id: CLIENT_ID, client_secret: CLIENT_SECRET, code: code, redirect_url: REDIRECT_URL})
    return JSON.parse(response.body)
  end
end

# Need this to authenticate with apps and get the access token.
# https://api.slack.com/tutorials/app-creation-and-oauth

# https://api.slack.com/methods/oauth.access