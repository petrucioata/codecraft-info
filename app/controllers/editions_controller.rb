# frozen_string_literal: true

class EditionsController < ApplicationController
  before_action :set_edition, only: %i[show edit update destroy]

  # GET /editions
  def index
    @editions = Edition.paginate(page: params[:page])
  end

  # GET /editions/:id
  def show
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
      redirect_to @edition, notice: 'Edition was successfully created.'
    else
      render action: :new
    end
  end

  # PUT|PATCH /editions/:id
  def update
    if @edition.update(edition_params)
      redirect_to @edition, notice: 'Edition was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /editions/:id
  def destroy
    @edition&.destroy
    redirect_to editions_path
  end

  private

  def edition_params
    params.required(:edition).permit(:name, :topic, :link, :description, :date)
  end

  def set_edition
    @edition = Edition.find(params[:id])
  end
end
