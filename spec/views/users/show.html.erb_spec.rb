require 'rails_helper'

RSpec.describe "users/show.html.erb", :type => :view do
  let (:t_user) { FactoryGirl.create(:user) }
  let (:t2_user) { FactoryGirl.create(:user, email: 't2@t2.com') }
  let (:tweet1) { FactoryGirl.create(:tweet, user: t1_user) }
  let (:tweet2) { FactoryGirl.create(:tweet, user: t2_user) }

  before do
    allow(User).to receive(:find).with(2).and_return(t_user)
    @user = User.find(2)
    allow(@user).to receive(:tweets).and_return([tweet2])
    @tweets = @user.tweets
    sign_in t_user
    allow(view).to receive(:signed_in?).and_return(true)
    render
  end

  it 'renders the email of the user' do
    expect(rendered).to have_content(@user.email)
  end

  it 'renders the tweets made by the user' do
    expect(rendered).to have_css('ul.tweets li.tweet')
  end
end
