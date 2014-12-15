class Tweet < ActiveRecord::Base
  validates :content, presence: true, length: { maximum: 140 }
  default_scope -> { order('created_at DESC') }
end
