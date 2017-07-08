class User < ApplicationRecord

  has_many :starred_repos
  has_many :followers
  has_many :followed_users

  def self.from_omniauth(response_data)
    where(uid: response_data[:uid]).first_or_create do |user|
      user.uid = response_data[:uid]
      user.name = response_data[:extra][:raw_info][:name]
      user.login = response_data[:extra][:raw_info][:login]
      user.token = response_data[:credentials][:token]
    end
  end

  def load_profile_data
    github_service = GithubService.new({token: self.token, login: self.login})
    populate_basic_profile(github_service.fetch_basic_profile)
    populate_followers(github_service.fetch_followers)

    # basic_data = Faraday.get("https://api.github.com/user?access_token=#{self.token}")
    # followers_data = Faraday.get("https://api.github.com/users/#{self.login}/followers?access_token=#{self.token}")
    # assign_followers(JSON.parse(followers_data.body, symbolize_names: true))
    # basic_info(JSON.parse(basic_data.body, symbolize_names: true))
  end

  def populate_basic_profile(profile_data)
    assign_attributes(avatar_url: profile_data[:avatar_url])
  end

  def populate_followers(follower_data)
    follower_data.each do |follower|
      Follower.find_or_create_by(follower_uid: follower[:id],
                                name: follower[:login],
                                user: self
                                )
    end
  end
end
