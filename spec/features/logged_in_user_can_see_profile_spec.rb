require 'rails_helper'

feature "Logged in user visits profile" do
  context "they see their user data" do

    before(:each) do
      stub_omniauth
    end
    it "they click Your profile link" do
      VCR.use_cassette("github_service.profile_basic_info") do
        visit root_path
        click_on "Login"
        click_on "Your Profile"
        user = User.find_by(uid: "12345678")
        expect(current_path).to eq(user_path(user))
        expect(page).to have_content("Sign Out")
        expect(page).to have_content("charliecorrigan")
        expect(page).to have_css('img', text: "#{user.avatar_url}")
        expect(page).to have_content("Stars #{user.starred_repos.count}")
        expect(page).to have_content("Followers #{user.followers.count}")
        expect(page).to have_content("Following #{user.followed_users.count}")
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