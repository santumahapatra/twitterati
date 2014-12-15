require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe '#show' do
    let (:user) { FactoryGirl.create(:user) }

    context 'for authenticated user' do
      before do
        sign_in user
      end

      it 'returns http success' do
        expect(:get => '/users/1').to route_to(:action => 'show', :controller => 'users', :id => '1')
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
end