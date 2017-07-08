class GithubService
  def initialize(args)
    @token = args[:token]
    @login = args[:login]
  end

  def fetch_basic_profile
    basic_data = Faraday.get("https://api.github.com/user?access_token=#{token}")
    JSON.parse(basic_data.body, symbolize_names: true)
  end

  def fetch_followers
    followers_data = Faraday.get("https://api.github.com/users/#{login}/followers?access_token=#{token}")
    JSON.parse(followers_data.body, symbolize_names: true)
  end

  def fetch_followed_users
    followed_users_data = Faraday.get("https://api.github.com/users/#{login}/following?access_token=#{token}")
    JSON.parse(followed_users_data.body, symbolize_names: true)
  end

  def fetch_starred_repos
    starred_repos_data = Faraday.get("https://api.github.com/users/#{login}/starred?access_token=#{token}")
    JSON.parse(starred_repos_data.body, symbolize_names: true)
  end

  def fetch_recent_activity
    recent_events_data = Faraday.get("https://api.github.com/users/#{login}/events?page=1&per_page=10&access_token=#{token}")
    JSON.parse(recent_events_data.body, symbolize_names: true)
  end

  private
    attr_reader :token, :login
end