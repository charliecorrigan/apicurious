require 'rails_helper'

RSpec.describe User, type: :model do
  it "is a valid user" do
    raw_user = {
      uid: "1234567",
      name: "Jimbo",
      login: "jimbotronXXX",
      token: "superlongstringthatislikeatoken"
    }

    user = User.new(raw_user)

    expect(user.uid).to eq("1234567")
    expect(user.name).to eq("Jimbo")
    expect(user.login).to eq("jimbotronXXX")
    expect(user.token).to eq("superlongstringthatislikeatoken")
  end
end
