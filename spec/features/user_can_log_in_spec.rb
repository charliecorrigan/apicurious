require 'rails_helper'

RSpec.describe "User logs in using github" do
  context "they authorize app to access github" do

    before(:each) do
      stub_omniauth
    end

    it "they click login link" do
      VCR.use_cassette("github_service.basic_login") do
        visit root_path
        click_on "Login"
        expect(page.status_code).to be(200)
        expect(page).to have_content("Logout")
        expect(page).to have_content("jimbotron")
      end
    end

    it "they click logout link" do
      VCR.use_cassette("github_service.basic_logout") do
        visit root_path
        click_on "Login"
        click_on "Logout"
        expect(page.status_code).to be(200)
        expect(page).not_to have_content("Logout")
        expect(page).to have_content("Login")
        expect(page).not_to have_content("jimbotron")
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
          login: "jimbotron",
        }
      },
      credentials: {
        token: ENV["github_user_token"],
      }
    })
  end
end
