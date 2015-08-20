class Album < ActiveRecord::Base
  validates :band_id, :name, :style, presence: true
end
