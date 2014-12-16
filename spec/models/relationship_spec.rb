require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  let(:follower) { FactoryGirl.create(:user, :email => 'hello@hello.com') }
  let(:followed) { FactoryGirl.create(:user, :email => 'random@random.com') }
  let(:relationship) { follower.relationships.build(followed_id: followed.id) }

  subject { relationship }

  it { is_expected.to be_valid }
end
