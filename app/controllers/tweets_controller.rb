class TweetsController < ApplicationController
  def index
    @tweet = Tweet.new
    @feed_items = Tweet.all
  end

  def create
    @tweet = Tweet.new(tweet_params)

    if @tweet.save
      render 'index'
    else
      render 'index', status: 400, error: 'Tweet cannot be created'
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:content)
    end
end
