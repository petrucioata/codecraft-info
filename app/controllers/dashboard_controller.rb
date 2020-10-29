# frozen_string_literal: true

require 'will_paginate/array'

class DashboardController < ApplicationController
  def index
    @participants_per_edition = participants_per_edition
    @implication_level = implication_level
    @average_points_per_edition = average_points_per_edition
    @first_places_per_edition = first_places.paginate(page: params[:page], per_page: 12)
  end

  private

  def first_places
    Edition.not_deleted.includes(:participations, :participants).each_with_object([]) do |edition, data|
      data << compute_values(edition)
    end
  end

  def points_for_first(edition, places: 5)
    edition.participations.first(places).map(&:total_points)
  end

  def names_of_first(edition, places: 5)
    edition.participants.first(places).map(&:full_name)
  end

  def compute_values(edition)
    {
      edition_date: edition.month_and_year,
      points_of_first: points_for_first(edition),
      names_of_first: names_of_first(edition)
    }
  end

  def average_points_per_edition
    Edition.not_deleted.includes(:participations_with_points).each_with_object([]) do |edition, data|
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
