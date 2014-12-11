class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
  end

  def create
  end
end
