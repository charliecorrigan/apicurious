class User < ApplicationRecord

  has_many :starred_repos
  has_many :followers
  has_many :followed_users
  has_many :recent_events
  has_many :followed_recent_events
  has_many :organizations

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
    populate_recent_activity(github_service.fetch_recent_activity)
    populate_organizations(github_service.fetch_organizations)
  end

  def populate_basic_profile(profile_data)
    assign_attributes(avatar_url: profile_data[:avatar_url])
  end

  def populate_followers(follower_data)
    Follower.where(user_id: self.id).destroy_all
    follower_data.each do |follower|
      Follower.create(follower_uid: follower[:id],
                                name: follower[:login],
                                user: self
                                )
    end
  end

  def populate_followed_users(followed_user_data)
    FollowedUser.where(user_id: self.id).destroy_all
    followed_user_data.each do |followed_user|
      FollowedUser.create(name: followed_user[:login],
                                    user: self
                                    )
    end
  end

  def populate_starred_repos(starred_repo_data)
    StarredRepo.where(user_id: self.id).destroy_all
    starred_repo_data.each do |starred_repo|
      StarredRepo.create(full_name: starred_repo[:full_name],
                                    user: self
                                    )
    end
  end

  def populate_recent_activity(recent_events_data)
    RecentEvent.where(user_id: self.id).destroy_all
    recent_events_data.each do |event|
      RecentEvent.create(event_type: event[:type],
                        repo: event[:repo][:name],
                        created_at: event[:created_at],
                        user: self)
    end
  end

  def load_root_data
    github_service = GithubService.new({token: self.token, login: self.login})
    populate_followed_recent_activity(github_service.fetch_followed_recent_activity)
  end

  def populate_followed_recent_activity(followed_activity_data)
    FollowedRecentEvent.where(user_id: self.id).destroy_all
    followed_activity_data.each do |event|
      FollowedRecentEvent.create(event_type: event[:type],
                        login: event[:actor][:display_login],
                        repo: event[:repo][:name],
                        user: self)
    end
  end

  def populate_organizations(organization_data)
    Organization.where(user_id: self.id).destroy_all
    organization_data.each do |org|
      Organization.create(login: org[:login],
                        user: self)
    end
  end
end
