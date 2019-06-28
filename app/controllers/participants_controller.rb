class ParticipantsController < ApplicationController
  def index
    @participants = Participant.all
  end

  def new
    @participant = Participant.new
  end

  def create
    @participant = Participant.new(participant_params)

    if @participant.save
      redirect_to @participant, notice: 'Participant was successfully created.'
    else
      render action: "new"
    end
  end

  private

  def participant_params
    params.required(:participant).permit(:username, :first_name, :last_name, :link, :position_id)
  end
end
