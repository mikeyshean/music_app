class AlbumsController < ApplicationController

  def new
    @album = Album.new
    @bands = Band.all
    @band = Band.find(params[:band_id])
  end

  def create
    @band = Band.find(params[:album][:band_id])
    @album = @band.albums.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = @album.errors.full_messages
      @bands = Band.all
      render :new
    end
  end

  def show
    @album = Album.find(params[:id])
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :name, :style)
  end

end
