require 'rails_helper'

feature "Logged in user visits profile" do
  it "they see their user data" do

    before(:each) do
      stub_omniauth
    end

    it "they click Your profile link" do
      visit root_path
      click_on "Login"
      click_on "Your Profile"
      user = User.find_by(uid: "12345678")
      expect(current_path).to eq(user_path(user))
      expect(page).to have_content("Logout")
      expect(page).to have_content("jimbotron")
      page.should have_css('img', text: "#{user.avatar_url}")
      expect(page).to have_content("Stars #{user.stars.count}")
      expect(page).to have_content("Followers #{user.followers.count}")
      expect(page).to have_content("Following #{user.following.count}")
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
        token: "supercrazylongtokenthing1234",
      }
    })
  end
end