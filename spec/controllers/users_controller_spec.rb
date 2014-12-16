require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe '#show' do
    let (:t_user) { FactoryGirl.create(:user) }
    let (:tweet1) { FactoryGirl.create(:tweet, :user => t_user) }
    let (:tweet2) { FactoryGirl.create(:tweet, :user => t_user) }

    context 'for authenticated user' do
      before do
        sign_in t_user
      end

      it 'returns http success' do
        expect(:get => '/users/1').to route_to(:action => 'show', :controller => 'users', :id => '1')
      end

      describe 'sets the instances' do
        before do
          allow(User).to receive(:find).with('1').and_return(t_user)
          get :show, id: 1.to_s
        end

        it 'sets the user instance' do
          expect(controller.params[:id]).to eql '1'
          expect(assigns(:user)).to eq(t_user)
        end

        it 'sets the tweets instance' do
          expect(assigns(:tweets)).to include(tweet1)
          expect(assigns(:tweets)).to include(tweet2)
        end
      end
    end

    context 'for non authenticated user' do
      before do
        sign_in nil
      end
      
      it 'returns http success' do
        expect(:get => '/users/1').to route_to(:action => 'show', :controller => 'users', :id => '1')
      end
    end
  end

  describe '#following' do
    let (:t_user) { FactoryGirl.create(:user) }
    let (:other_user) { FactoryGirl.create(:user, :email => 'notrandm@random.com' ) }

    before do
      allow(User).to receive(:find).with('2').and_return(other_user)
      other_user.follow!(t_user)
      get :following, id: 2.to_s
    end

    it 'sets the user instance' do
      expect(controller.params[:id]).to eql '2'
      expect(assigns(:user)).to eq(other_user)
    end

    it 'sets the users instance' do
      expect(assigns(:users)).to include(t_user)
    end 
  end

  describe '#followers' do
    let (:t_user) { FactoryGirl.create(:user) }
    let (:other_user) { FactoryGirl.create(:user, :email => 'notrandm@random.com' ) }

    before do
      allow(User).to receive(:find).with('2').and_return(other_user)
      t_user.follow!(other_user)
      get :followers, id: 2.to_s
    end

    it 'sets the user instance' do
      expect(controller.params[:id]).to eql '2'
      expect(assigns(:user)).to eq(other_user)
    end

    it 'sets the users instance' do
      expect(assigns(:users)).to include(t_user)
    end 
  end
end
