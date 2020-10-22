# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /
  def index
    @participants_per_edition = participants_per_edition
    @implication_level = implication_level
  end

  private

  def participants_per_edition
    Participation.all.includes(:edition)
                 .reject { |participation| participation.edition.deleted }
                 .group_by { |participation| participation.edition.date.strftime('%b%y') }
                 .each_with_object([]) do |(key, value), data|
      data << {
        name: key,
        number: value.count,
        with_points: value.count { |participation| participation.total_points.positive? }
      }
    end
  end

  def implication_level
    Participant.not_deleted.includes(:position)
               .group_by { |participant| participant.position&.short_name }
               .transform_values(&:count).each_with_object([]) do |(short_name, count), data|
      data << {
        position: short_name,
        value: count
      }
    end
  end
end
