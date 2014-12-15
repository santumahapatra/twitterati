require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  it { is_expected.to respond_to(:tweets) }
end
