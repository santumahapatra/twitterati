require 'rails_helper'

RSpec.describe "users/index.html.erb", :type => :view do
  let (:user) { FactoryGirl.create(:user) }
  let (:tweet1) { FactoryGirl.create(:tweet) }
  let (:tweet2) { FactoryGirl.create(:tweet) }

  before do
    allow(view).to receive(:current_user).and_return(user)
    @tweets = user.tweets
    #render
  end

  it 'renders the email of the user' do
    #expect(rendered).to have_content(user.email)
  end

  it 'renders the tweets made by the user' do
    #expect(rendered).to have_css()
  end
end