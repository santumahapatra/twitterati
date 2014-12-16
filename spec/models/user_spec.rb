require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { is_expected.to respond_to(:tweets) }
  it { is_expected.to respond_to(:relationships) }
  it { is_expected.to respond_to(:followed_users) }
  it { is_expected.to respond_to(:reverse_relationships) }
  it { is_expected.to respond_to(:followers) }
  it { is_expected.to respond_to(:following?) }
  it { is_expected.to respond_to(:follow!) }
  it { is_expected.to respond_to(:unfollow!) }

  describe "following" do
    let(:other_user) { FactoryGirl.create(:user, :email => 'other@other.com') }
    before do
      user.save
      user.follow!(other_user)
    end

    it { is_expected.to be_following(other_user) }
    its(:followed_users) { is_expected.to include(other_user)}

    describe "followed user" do
      subject { other_user }
      its(:followers) { is_expected.to include(user) }
    end

    describe "and unfollowing" do
      before { user.unfollow!(other_user) }
      
      it { is_expected.not_to be_following(other_user) }
      its(:followed_users) { is_expected.not_to include(other_user)}
    end
  end
end
