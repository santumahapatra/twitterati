class TweetsController < ApplicationController
  before_action :authenticate_user!, :only => [:index, :create]
  before_action :current_user, :only => [:index, :create]

  def index
    @tweet  = current_user.tweets.build
    feed
  end

  def create
    @tweet = current_user.tweets.build(tweet_params)
    feed

    if @tweet.save
      redirect_to root_path
    else
      render 'index', status: 400, error: 'Tweet cannot be created'
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end

    def feed
      @feed_items = Tweet.all
    end
end
