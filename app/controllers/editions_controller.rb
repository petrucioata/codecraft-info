class EditionsController < ApplicationController
  before_action :set_edition, only: [:show, :edit, :update, :delete]

  # GET /editions
  def index
    @editions = Edition.all
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
      redirect_to @edition, notice: 'Edition was succesfully created.'
    else
      render action: "new"
    end
  end

  # PUT /editions/:id
  def update
    if @edition.update_attributes(edition_params)
      redirect_to @edition, notice: 'Edition was succesfully updated.'
    else
      render action: "new"
    end
  end

  def delete
    @edition.destroy
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
