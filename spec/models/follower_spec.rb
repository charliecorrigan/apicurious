require 'rails_helper'

RSpec.describe Follower, type: :model do

  it { should belong_to :user }

  it "is a valid follower" do
    user = User.create(uid: "1234567",
                    name: "Jimbo",
                    login: "jimbotronXXX",
                    token: "superlongstringthatislikeatoken"
                    )

    raw_follower = {
      user_id: user.id,
      name: "Bobby Sue"
    }

    follower = Follower.create(raw_follower)


    expect(follower.name).to eq("Bobby Sue")
    expect(follower.user.uid).to eq("1234567")
    expect(user.followers.first.name).to eq("Bobby Sue")
    expect(user.followers.count).to eq(1)
  end
end
