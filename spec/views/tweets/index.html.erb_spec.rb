require 'rails_helper'

RSpec.describe "tweets/index.html.erb", :type => :view do

  before do
    @tweet = Tweet.new
    render
  end

  it 'renders the main page' do
    expect(rendered).to have_content('What are you doing?')
  end

  it 'renders the create tweet form' do
    expect(rendered).to have_selector("form[class='new_tweet']")
    expect(rendered).to have_selector("input[name='tweet[content]']")
  end
end