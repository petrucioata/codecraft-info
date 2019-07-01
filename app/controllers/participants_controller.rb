class ParticipantsController < ApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants
  def index
    @participants = Participant.all
  end

  # GET /participants/:id
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/:id/edit
  def edit
  end

  # POST /participants
  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      redirect_to @participant, notice: 'Participant was successfully created.'
    else
      render action: :new
    end
  end

  # PUT|PATCH /participants/:id
  def update
    if @participant.update_attributes(participant_params)
      redirect_to @participant, notice: 'Participant was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /participants/:id
  def destroy
    @participant.destroy if @participant
    redirect_to participants_path
  end

  private

  def participant_params
    params.required(:participant).permit(:username, :first_name, :last_name, :link, :position_id)
  end

  def set_participant
    @participant = Participant.find(params[:id])
  end
end
