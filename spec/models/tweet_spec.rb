require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  let (:tweet) { Tweet.new }

  it { is_expected.to respond_to(:content) }
end
