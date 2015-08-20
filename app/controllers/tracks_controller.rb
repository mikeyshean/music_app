class TracksController < ApplicationController

  def new
    @track = Track.new
  end

  def create
    @album = Album.find(params[:track][:album_id])
    @track = @album.tracks.new(track_params)
  end

  def destroy
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :lyrics)
  end
end
