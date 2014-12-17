require 'rails_helper'

RSpec.describe "users/show_follow.html.erb", :type => :view do
  let (:t1_user) { FactoryGirl.create(:user) }
  let (:t2_user) { FactoryGirl.create(:user, email: 't2@user.com') }
  let (:t3_user) { FactoryGirl.create(:user, email: 't3@user.com') }
  let (:tweet1) { FactoryGirl.create(:tweet, user: t1_user) }
  let (:tweet2) { FactoryGirl.create(:tweet, user: t1_user) }

  before do
    t1_user.follow!(t2_user)
    t1_user.follow!(t3_user)
    t2_user.follow!(t1_user)
    allow(User).to receive(:find).with(1).and_return(t1_user)
    @user = User.find(1)
    allow(@user).to receive_message_chain(:tweets, :count).and_return(2)
  end

  describe 'shows the users that a user is following' do
    before do
      @users = @user.followed_users
      render
    end

    subject { rendered }

    it { is_expected.to have_content(@user.email) }
    it { is_expected.to have_selector("a[href='/users/1']") }
    it { is_expected.to have_content(@user.tweets.count) }

    describe "show the following and followers routes" do
      it { is_expected.to have_selector("a[href='/users/1/following']") }
      it { is_expected.to have_selector("a[href='/users/1/followers']") }
    end
  end

  # describe 'show the followers of a user' do
  #   before do
  #     @users = @user.followers
  #     render
  #   end
  # end
end
