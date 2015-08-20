class NotesController < ApplicationController
  before_action :authorized_user?, only: :destroy

  def create
    @track = Track.find(params[:note][:track_id])
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to track_url(@track)
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to track_url(@track)
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to track_url(@note.track)
  end

  private

  def note_params
    params.require(:note).permit(:user_id, :track_id, :text)
  end

  def authorized_user?
    note = Note.find(params[:id])
    if current_user != note.user
      render text: "You're not allowed to do that!"
    end
  end
end
