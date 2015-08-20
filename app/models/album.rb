class Album < ActiveRecord::Base

  STYLES = %w{ studio live }
  validates :band_id, :name, :style, presence: true
  belongs_to :band
  has_many :tracks
end
