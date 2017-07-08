require 'rails_helper'

describe GithubService do

  before(:each) do
    stub_omniauth
  end

  context ".initialize" do
    it "returns an object" do
      github_service = GithubService.new({token: ENV["github_user_token"], login: "charliecorrigan"})

      expect(github_service).to be_a GithubService
    end
  end

  context "#fetch_basic_profile" do
    it "returns a hash" do
      VCR.use_cassette("github_service.fetch_basic_profile") do
        github_service = GithubService.new({token: ENV["github_user_token"], login: "charliecorrigan"})
        basic_profile = github_service.fetch_basic_profile
        expect(basic_profile[:avatar_url]).to be_a String
        expect(basic_profile[:avatar_url]).to eq("https://avatars2.githubusercontent.com/u/20289631?v=3")
      end
    end
  end

  context "#fetch_followers" do
    it "returns an array of hashes" do
      VCR.use_cassette("github_service.fetch_followers") do
        github_service = GithubService.new({token: ENV["github_user_token"], login: "charliecorrigan"})
        followers = github_service.fetch_followers
        follower = followers.first
        expect(followers).to be_an Array
        expect(follower).to be_a Hash
        expect(followers.count).to eq(2)
        expect(follower).to have_key(:login)
        expect(follower[:login]).to be_a String
        expect(follower).to have_key(:id)
        expect(follower[:id]).to be_an Integer
      end
    end
  end

  context "#fetch_followed_users" do
    it "returns an array of hashes" do
      VCR.use_cassette("github_service.fetch_followed_users") do
        github_service = GithubService.new({token: ENV["github_user_token"], login: "charliecorrigan"})
        followed_users = github_service.fetch_followed_users
        followed_user = followed_users.first

        expect(followed_users).to be_an Array
        expect(followed_user).to be_a Hash
        expect(followed_users.count).to eq(3)
        expect(followed_user).to have_key(:login)
        expect(followed_user[:login]).to be_a String
        expect(followed_user).to have_key(:id)
        expect(followed_user[:id]).to be_an Integer
      end
    end
  end

  context "#fetch_starred_repos" do
    it "returns an array of hashes" do
      VCR.use_cassette("github_service.fetch_starred_repos") do
        github_service = GithubService.new({token: ENV["github_user_token"], login: "charliecorrigan"})
        starred_repos = github_service.fetch_starred_repos
        starred_repo = starred_repos.first

        expect(starred_repos).to be_an Array
        expect(starred_repo).to be_a Hash
        expect(starred_repos.count).to eq(1)
        expect(starred_repo).to have_key(:full_name)
        expect(starred_repo[:full_name]).to be_a String
      end
    end
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "12345678",
      extra: {
        raw_info: {
          name: "Jimbo",
          login: "charliecorrigan",
        }
      },
      credentials: {
        token: ENV["github_user_token"],
      }
    })
  end
end