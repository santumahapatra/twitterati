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

  describe "tweet associations" do

    before { user.save }
    let!(:older_tweet) do
      FactoryGirl.create(:tweet, user: user, created_at: 1.day.ago)
    end
    let!(:newer_tweet) do
      FactoryGirl.create(:tweet, user: user, created_at: 1.hour.ago)
    end

    it "should have the right tweets in the right order" do
      expect(user.tweets.to_a).to eq [newer_tweet, older_tweet]
    end

    it "should destroy associated tweets" do
      tweets = user.tweets.to_a
      user.destroy
      expect(tweets).not_to be_empty
      tweets.each do |tweet|
        expect(Tweet.where(id: tweet.id)).to be_empty
      end
    end

    describe "status" do
      let(:unfollowed_post) do
        FactoryGirl.create(:tweet, user: FactoryGirl.create(:user, :email => 'unfollowed@user.com'))
      end
      let(:followed_user) { FactoryGirl.create(:user, :email => 'hello@hello.com') }

      before do
        user.follow!(followed_user)
        3.times { followed_user.tweets.create!(content: "Lorem ipsum") }
      end

      its(:feed) { is_expected.to include(newer_tweet) }
      its(:feed) { is_expected.to include(older_tweet) }
      its(:feed) { is_expected.not_to include(unfollowed_post) }
      its(:feed) do
        followed_user.tweets.each do |tweet|
          is_expected.to include(tweet)
        end
      end
    end
  end

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
