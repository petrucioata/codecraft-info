# frozen_string_literal: true

class EditionsController < ApplicationController
  before_action :set_edition, only: %i[show edit update destroy new_import import]
  before_action :authorize, only: %i[new create edit update destroy new_import import]

  # GET /editions
  def index
    @editions = Edition.paginate(page: params[:page])
  end

  # GET /editions/:id
  def show
    @participations = @edition
                      .participations
                      .includes(participant: :position)
                      .search(params)
                      .paginate(page: params[:page])
    @positions = Position.pluck(:short_name, :id)
  end

  # GET /editions/new
  def new
    @edition = Edition.new
  end

  # GET /editions/:id/edit
  def edit
  end

  # POST /editions
  def create
    @edition = Edition.new(edition_params)

    if @edition.save
      redirect_to @edition, success: 'Edition was successfully created.'
    else
      flash[:warning] = helpers.error_messages(@edition.errors)
      render action: :new
    end
  end

  # PUT|PATCH /editions/:id
  def update
    if @edition.update(edition_params)
      redirect_to @edition, success: 'Edition was successfully updated.'
    else
      flash[:warning] = helpers.error_messages(@edition.errors)
      render action: :edit
    end
  end

  # DELETE /editions/:id
  def destroy
    @edition&.destroy
    flash[:success] = 'Edition was successfully deleted.'
    redirect_to editions_path
  end

  # GET/editions/:id/import
  def new_import
  end

  # POST /editions/:id/import
  def import
    if @edition&.import_csv(params[:file])
      redirect_to edition_path(@edition), success: 'Edition details were imported.'
    else
      flash[:warning] = 'Data were not imported.'
      render action: :new_import
    end
  end

  private

  def edition_params
    params.required(:edition).permit(:name, :topic, :link, :description, :date)
  end

  def set_edition
    @edition = Edition.find(params[:id])
  end
end
