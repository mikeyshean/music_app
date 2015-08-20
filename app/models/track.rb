class Track < ActiveRecord::Base
  validates :album_id, :name, :lyrics, presence: true
  belongs_to :album
  has_one :band, :through => :album

end
