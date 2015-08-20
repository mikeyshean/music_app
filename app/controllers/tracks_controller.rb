class TracksController < ApplicationController
  before_action :require_login

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @albums = Album.where(band_id: @album.band_id)
  end

  def create
    @album = Album.find(params[:track][:album_id])
    @track = @album.tracks.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      @albums = @track.albums
      render :new
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to album_url(@track.album)
  end

  def show
    @track = Track.find(params[:id])
    @note = Note.new
    @notes = @track.notes.order(created_at: :desc)
  end

  private

  def track_params
    params.require(:track).permit(:album_id, :name, :lyrics)
  end
end
