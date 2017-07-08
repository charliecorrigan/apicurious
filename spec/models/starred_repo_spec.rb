require 'rails_helper'

RSpec.describe StarredRepo, type: :model do

  it { should belong_to :user }

  it "is a valid starred_repo" do
    user = User.create(uid: "1234567",
                    name: "Jimbo",
                    login: "jimbotronXXX",
                    token: "superlongstringthatislikeatoken"
                    )

    raw_starred_repo = {
      user_id: user.id,
      full_name: "bobbysue/awesome_repo"
    }

    starred_repo = StarredRepo.create(raw_starred_repo)


    expect(starred_repo.full_name).to eq("bobbysue/awesome_repo")
    expect(starred_repo.user.uid).to eq("1234567")
    expect(user.starred_repos.first.full_name).to eq("bobbysue/awesome_repo")
    expect(user.starred_repos.count).to eq(1)
  end
end