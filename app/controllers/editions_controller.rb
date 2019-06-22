class EditionsController < ApplicationController
  before_action :set_edition, only: [:show, :edit, :delete]

  def index
    @editions = Edition.all
  end

  def show
  end

  def edit
  end

  def delete
  end

  private

  def edition_params
    params.required(:edition).permit(:name, :topic, :link, :description, :date)
  end

  def set_edition
    @edition = Edition.find(params[:id])
  end
end
