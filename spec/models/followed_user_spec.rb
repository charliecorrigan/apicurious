require 'rails_helper'

RSpec.describe FollowedUser, type: :model do

  it { should belong_to :user }

  it "is a valid followed_user" do
    user = User.create(uid: "1234567",
                    name: "Jimbo",
                    login: "jimbotronXXX",
                    token: "superlongstringthatislikeatoken"
                    )

    raw_followed_user = {
      user_id: user.id,
      name: "Bobby Sue"
    }

    followed_user = FollowedUser.create(raw_followed_user)


    expect(followed_user.name).to eq("Bobby Sue")
    expect(followed_user.user.uid).to eq("1234567")
    expect(user.followed_users.first.name).to eq("Bobby Sue")
    expect(user.followed_users.count).to eq(1)
  end
end