require 'rails_helper'

feature "Logged in user visits profile" do
  context "they see the organizations they belong to" do

    before(:each) do
      stub_omniauth
    end

    it "they click Your profile link" do
      VCR.use_cassette("github_service.profile_organizations") do
        visit root_path
        click_on "Login"
        click_on "Your Profile"
        user = User.find_by(uid: "12345678")

        expect(current_path).to eq(user_path(user))
        expect(page).to have_content("Logout")
        expect(page).to have_content("charliecorrigan")

        expect(page).to have_selector(".organizations")
        expect(page).to have_content(user.organizations.first.login)
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