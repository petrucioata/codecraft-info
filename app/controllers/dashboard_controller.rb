# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /
  def index
    @participants_per_edition = participants_per_edition
  end

  private

  def participants_per_edition
    Edition.all.each_with_object([]) do |edition, data|
      data << { name: edition.name, number: edition.participants.count }
    end
  end
end
