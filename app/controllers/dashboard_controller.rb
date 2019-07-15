# frozen_string_literal: true

class DashboardController < ApplicationController
  # GET /root
  def index
    @editions = Edition.all.each_with_object([]) do |edition, data|
      data << { name: edition.name, nr: edition.participants.count }
    end
  end
end
