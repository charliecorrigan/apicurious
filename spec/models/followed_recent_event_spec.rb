require 'rails_helper'

RSpec.describe FollowedRecentEvent, type: :model do

  it { should belong_to :user }

  it "is a valid recent_event" do
    user = User.create(uid: "1234567",
                    name: "Jimbo",
                    login: "jimbotronXXX",
                    token: "superlongstringthatislikeatoken"
                    )

    raw_recent_event = {
      user_id: user.id,
      event_type: "PullRequest",
      login: "nice_classmate_99",
      repo: "that_guy/awesome_app",
    }

    recent_event = FollowedRecentEvent.create(raw_recent_event)

    expect(recent_event.event_type).to eq("PullRequest")
    expect(recent_event.user.uid).to eq("1234567")
    expect(user.followed_recent_events.first.repo).to eq("that_guy/awesome_app")
    expect(user.followed_recent_events.first.login).to eq("nice_classmate_99")
    expect(user.followed_recent_events.count).to eq(1)
  end
end
