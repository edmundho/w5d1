require 'rails_helper'

RSpec.describe User, type: :model do


  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }

  subject { user = User.create(username: 'spike', password: 'password', session_token: "32910") }

  it { should validate_uniqueness_of(:username) }


  # it { should have_many}
  it { should validate_length_of(:password).is_at_least(6) }

  describe 'User::find_by_credentials' do
    # subject{ user = User.create(username: 'spike', password: 'password', session_token: "291378021") }

    it 'find the correct user' do
      user = User.create(username: 'spike', password: 'password', session_token: "291378021")
      spike = User.find_by_credentials('spike', 'password')
      expect(spike).to eq(user)
    end

    it 'properly returns nil if  no user' do
      user = User.create(username: 'spike', password: 'password', session_token: "291378021")
      u = User.find_by_credentials('ed', 'password')
      expect(u).to eq(nil)
    end

  end
end
