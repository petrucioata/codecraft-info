# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /
  def index
    @participants_per_edition = participants_per_edition
  end

  private

  def participants_per_edition
    Edition.all.order(:date).each_with_object([]) do |edition, data|
      data << {
        name: edition.date.strftime('%b%y'),
        number: edition.participants.count,
        with_points: edition.participations.with_points
      }
    end
  end
end
