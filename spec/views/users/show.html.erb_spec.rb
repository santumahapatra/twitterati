require 'rails_helper'

RSpec.describe "users/show.html.erb", :type => :view do
  let (:t_user) { FactoryGirl.create(:user) }
  let (:tweet1) { FactoryGirl.create(:tweet, :user => t_user) }
  let (:tweet2) { FactoryGirl.create(:tweet, :user => t_user) }

  before do
    allow(User).to receive(:find).with(1).and_return(t_user)
    @user = User.find(1)
    allow(@user).to receive(:tweets).and_return([tweet2, tweet1])
    @tweets = @user.tweets
    render
  end

  it 'renders the email of the user' do
    expect(rendered).to have_content(@user.email)
  end

  it 'renders the tweets made by the user' do
    expect(rendered).to have_css('ul.tweets li.tweet')
  end
end
