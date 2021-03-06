class NotesController < ApplicationController

  def index
    @q = Note.ransack(params[:q])
    @notes = @q.result(distinct: true)
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @notepad = params[:note][:notepad_id]
    if @note.save
      redirect_to notepad_path(@notepad)
    else
      redirect_to new_note_path
      flash[:error] = @note.errors.full_messages
    end
  end

  def show
    @note = Note.find(params[:id])
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    if @note.update(note_params)
      redirect_to @note
    else
      render :edit
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to notes_path
  end

  private

  def note_params
    params.require(:note).permit(:title, :text, :notepad_id, {pictures: []})
  end

end
