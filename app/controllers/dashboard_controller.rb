# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /
  def index
    @participants_per_edition = participants_per_edition
    @implication_level = implication_level
    @average_points_per_edition = average_points_per_edition
    @first_five_places = first_places
  end

  private

  def first_places
    Edition.not_deleted.includes(:participations, :participants).each_with_object([]) do |edition, data|
      data << compute_values(edition)
    end
  end

  def first_five_points(edition)
    edition.participations.first(5).map(&:total_points)
  end

  def first_five_participants(edition)
    edition.participants.first(5).map(&:username)
  end

  def compute_values(edition)
    points = first_five_points(edition)
    participants = first_five_participants(edition)
    {
      year: edition.month_and_year,
      first_place_points: points[0],
      second_place_points: points[1],
      third_place_points: points[2],
      fourth_place_points: points[3],
      fifth_place_points: points[4],
      first_place_username: participants[0],
      second_place_username: participants[1],
      third_place_username: participants[2],
      fourth_place_username: participants[3],
      fifth_place_username: participants[4]
    }
  end

  def average_points_per_edition
    Edition.not_deleted.includes(:participations_with_points).each_with_object([]) do |edition, data|
      # participation_with_points = edition.participations.with_points
      data << {
        name: edition.month_and_year,
        number: calculate_average(edition.participations_with_points)
      }
    end
  end

  def calculate_average(participations)
    return 0 if participations.size.zero?

    participations.pluck(:total_points).sum / participations.size
  end

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
