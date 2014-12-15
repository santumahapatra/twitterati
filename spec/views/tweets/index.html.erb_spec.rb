require 'rails_helper'

RSpec.describe "tweets/index.html.erb", :type => :view do

  let (:user) { FactoryGirl.create(:user) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    @tweet = user.tweets.build
    @feed_items = Tweet.all
    render
  end

  it 'renders the main page' do
    expect(rendered).to have_content("What's happening?")
  end

  it 'renders the create tweet form' do
    expect(rendered).to have_selector('form.form.tweet-form')
    expect(rendered).to have_selector("textarea[name='tweet[content]']")
  end

  it 'renders the feed' do
    expect(rendered).to have_selector('.panel.feed-container')
  end
end