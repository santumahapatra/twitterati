require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  let(:tweet) { FactoryGirl.create(:tweet) }

  it { is_expected.to respond_to(:content) }

  describe 'is invalid' do
    it 'if content is blank' do
      expect( Tweet.new(content: '') ).not_to be_valid
    end

    it 'if content is more than 140 characters' do
      long_input = 'a' * 141
      expect( Tweet.new(content: long_input) ).not_to be_valid
    end
  end

  describe 'is valid' do
    it 'if content is less than 140 characters' do
      expect( Tweet.new(content: "Hello World") ).to be_valid
    end
  end

  describe 'returns tweets' do
    it 'in reverse chronological order' do
      @tweet1 = FactoryGirl.create(:tweet, content: "hello1")
      @tweet2 = FactoryGirl.create(:tweet, content: "hello2")
      @tweet3 = FactoryGirl.create(:tweet, content: "hello3")
      expect( Tweet.all ).to eq([@tweet3, @tweet2, @tweet1])
    end
  end
end
