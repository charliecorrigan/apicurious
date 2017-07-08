require 'rails_helper'

RSpec.describe RecentEvent, type: :model do

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
      repo: "charlie/awesome_app",
      created_at: DateTime.now
    }

    recent_event = RecentEvent.create(raw_recent_event)

    expect(recent_event.event_type).to eq("PullRequest")
    expect(recent_event.user.uid).to eq("1234567")
    expect(user.recent_events.first.repo).to eq("charlie/awesome_app")
    expect(user.recent_events.count).to eq(1)
  end
end
