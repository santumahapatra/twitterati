require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  before { @tweet = user.tweets.build(content: "Hello") }

  subject { @tweet }

  it { is_expected.to respond_to(:content) }
  it { is_expected.to respond_to(:user_id) }

  context 'is invalid' do
    describe "when user_id is not present" do
      before { @tweet.user_id = nil }
      it { is_expected.not_to be_valid }
    end

    describe 'if content is blank' do
      before { @tweet.content = '' }
      it { is_expected.not_to be_valid }
    end

    describe 'if content is more than 140 characters' do
      long_input = 'a' * 141
      before { @tweet.content = long_input }
      it { is_expected.not_to be_valid }
    end
  end

  context 'is valid' do
    describe 'if content is less than 140 characters' do
      it { is_expected.to be_valid }
    end
  end

  describe 'returns tweets' do
    it 'in reverse chronological order' do
      @tweet1 = FactoryGirl.create(:tweet, content: "hello1", user_id: 1)
      @tweet2 = FactoryGirl.create(:tweet, content: "hello2", user_id: 1)
      @tweet3 = FactoryGirl.create(:tweet, content: "hello3", user_id: 1)
      expect( Tweet.all ).to eq([@tweet3, @tweet2, @tweet1])
    end
  end
end
