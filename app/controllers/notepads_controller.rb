class NotepadsController < ApplicationController

    def index
      @notepad = Notepad.all
    end

    def new
      @notepad = Notepad.new
    end

    def create
      @notepad = Notepad.new(notepad_params)
      if @notepad.save
        redirect_to @notepad
      else
        redirect_to new_notepad_path
        flash[:error] = "The Notepad name must be unique"
      end
    end

    def show
      @notepad = Notepad.find(params[:id])
      @notes = @notepad.notes.all
    end

    def notepad_params
      params.require(:notepad).permit(:title)
    end

    def edit
      @notepad = Notepad.find(params[:id])
    end

    def update
      @notepad = Notepad.find(params[:id])
      if @notepad.update(notepad_params)
        redirect_to @notepad
      else
        render :edit
      end
    end

    def destroy
      @notepad = Notepad.find(params[:id])
      @notepad.destroy

      redirect_to notepads_path
      flash[:error] = "The Notepad was successfully deleted"
    end
end
