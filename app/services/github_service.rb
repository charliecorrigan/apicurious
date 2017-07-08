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

  private
    attr_reader :token, :login
end