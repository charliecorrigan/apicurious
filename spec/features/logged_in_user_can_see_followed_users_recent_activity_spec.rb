require 'rails_helper'

feature "Logged in user visits root" do
  context "they see their followed user's recent activity" do

    before(:each) do
      stub_omniauth
    end

    it "they visit root" do
      VCR.use_cassette("github_service.root_activity_feed") do
        visit root_path
        click_on "Login"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sign Out")
        expect(page).to have_content("charliecorrigan")

        expect(page).to have_selector(".recent-activity", count: 10)

        within first(".recent-activity") do
          expect(page).to have_selector(".recent-activity-login")
          expect(page).to have_selector(".recent-activity-type")
          expect(page).to have_selector(".recent-activity-repo")
        end
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