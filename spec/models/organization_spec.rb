require 'rails_helper'

RSpec.describe Organization, type: :model do

  it { should belong_to :user }

  it "is a valid organization" do
    user = User.create(uid: "1234567",
                    name: "Jimbo",
                    login: "jimbotronXXX",
                    token: "superlongstringthatislikeatoken"
                    )

    raw_organization = {
      user_id: user.id,
      login: "1703be organization thing"
    }

    organization = Organization.create(raw_organization)


    expect(organization.login).to eq("1703be organization thing")
    expect(organization.user.uid).to eq("1234567")
    expect(user.organizations.first.login).to eq("1703be organization thing")
    expect(user.organizations.count).to eq(1)
  end
end