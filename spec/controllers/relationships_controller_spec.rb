require 'rails_helper'

RSpec.describe RelationshipsController, :type => :controller do

  let(:t_user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user, :email => 'hello@hello.com' ) }

  before { sign_in t_user }

  describe "#create" do

    it "should increment the Relationship count" do
      expect do
        xhr :post, :create, relationship: { followed_id: other_user.id }
      end.to change(Relationship, :count).by(1)
    end

    it "should respond with success" do
      xhr :post, :create, relationship: { followed_id: other_user.id }
      expect(response).to be_success
    end
  end

  describe "#destroy" do

    before { t_user.follow!(other_user) }
    let(:relationship) do
      t_user.relationships.find_by(followed_id: other_user.id)
    end

    it "should decrement the Relationship count" do
      expect do
        xhr :delete, :destroy, id: relationship.id
      end.to change(Relationship, :count).by(-1)
    end

    it "should respond with success" do
      xhr :delete, :destroy, id: relationship.id
      expect(response).to be_success
    end
  end
end