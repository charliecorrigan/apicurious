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
    populate_followed_users(github_service.fetch_followed_users)
    populate_starred_repos(github_service.fetch_starred_repos)
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

  def populate_followed_users(followed_user_data)
    followed_user_data.each do |followed_user|
      FollowedUser.find_or_create_by(name: followed_user[:login],
                                    user: self
                                    )
    end
  end

  def populate_starred_repos(starred_repo_data)
    starred_repo_data.each do |starred_repo|
      StarredRepo.find_or_create_by(full_name: starred_repo[:full_name],
                                    user: self
                                    )
    end
  end
end
