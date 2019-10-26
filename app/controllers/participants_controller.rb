# frozen_string_literal: true

class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[show edit update destroy]
  before_action :authorize#, only: %i[new create edit update destroy]

  # GET /participants
  def index
    @participants = Participant.search(params).paginate(page: params[:page])
    @positions = Position.pluck(:short_name, :id)
  end

  # GET /participants/:id
  def show
    @participations = @participant.participations.paginate(page: params[:page])
    @chart_data = @participations.map do |participation|
      { number: participation.total_points, name: participation.edition.name }
    end
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
      redirect_to @participant, success: 'Participant was successfully created.'
    else
      flash[:warning] = helpers.error_messages(@participant.errors)
      render action: :new
    end
  end

  # PUT|PATCH /participants/:id
  def update
    if @participant.update(participant_params)
      redirect_to @participant, success: 'Participant was successfully updated.'
    else
      flash[:warning] = helpers.error_messages(@participant.errors)
      render action: :edit
    end
  end

  # DELETE /participants/:id
  def destroy
    @participant&.destroy
    flash[:success] = 'Participant was successfully deleted.'
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
