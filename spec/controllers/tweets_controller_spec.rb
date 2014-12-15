require 'rails_helper'

RSpec.describe TweetsController, :type => :controller do

  describe '#index' do
    context 'for authenticated user' do
      before do
        sign_in
        get :index
      end

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'has a instance variable tweet which is a new Tweet' do
        expect(assigns(:tweet)).to be_a_new(Tweet)
      end

      it 'has a instance variable feed which has all Tweets' do
        expect(assigns(:feed_items)).to eq(Tweet.all)
      end
    end

    context 'for non authenticated user' do
      before do
        sign_in nil
        get :index
      end

      it 'redirects to login route' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'for authenticated user' do
      before do
        sign_in
      end

      it 'redirects to root path if tweet is valid' do
        post :create, tweet: { content: 'abc' }
        expect(response).to redirect_to(root_path)
      end

      it 'shows error message if tweet is not valid' do
        post :create, tweet: { content: '' }
        expect(response).not_to have_http_status(:success)
      end
    end

    context 'for non authenticated user' do
      before do
        sign_in nil
      end

      it 'redirects to login route' do
        post :create, tweet: { content: 'abc' }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end