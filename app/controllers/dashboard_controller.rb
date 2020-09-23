# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /
  def index
    @participants_per_edition = participants_per_edition
    @implication_level = implication_level
  end

  private

  def participants_per_edition
    Edition.all_not_deleted.order(:date).each_with_object([]) do |edition, data|
      data << {
        name: edition.date.strftime('%b%y'),
        number: edition.participants.count,
        with_points: edition.participations.with_points
      }
    end
  end

  def implication_level
    Position.all_not_deleted.each_with_object([]) do |position, data|
      data << {
        position: position.short_name,
        value: position.participants.joins(:participations).count
      }
    end
  end
end
