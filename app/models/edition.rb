# frozen_string_literal: true

require 'csv'

class Edition < ApplicationRecord
  has_many :participations, dependent: :destroy
  has_many :participants, through: :participations

  has_many :tasks, dependent: :nullify

  validates :name, uniqueness: true
  validates :link, uniqueness: true

  validates :name, presence: true
  validates :link, presence: true
  validates :date, presence: true

  validate :unique_month_and_year

  scope :not_deleted, -> { where(deleted: false) }

  def import_csv(file)
    rows = CSV.read(file.path, headers: true)
    tasks = find_or_create_tasks(rows.headers[2..4])

    rows.each do |row|
      participant = find_or_create_participant(row['username'])
      participation = find_or_create_participation(participant, row['points'], row['total_time'], row['nr_crt'])
      find_or_create_solutions(participation, tasks, row)
    end
  rescue StandardError => e
    e.message
    false
  end

  private

  def find_or_create_tasks(tasks_name)
    tasks_name.each_with_object([]) do |task_name, tasks|
      tasks << Task.where(name: task_name, edition: self).first_or_create
    end
  end

  def find_or_create_participant(username)
    profile_url = 'https://app.codesignal.com/profile'
    Participant.where(username: username).first_or_create do |participant|
      participant.link = "#{profile_url}/#{username}"
    end
  end

  def find_or_create_participation(participant, points, time, rank)
    Participation.where(participant: participant, edition: self).first_or_create do |part|
      part.total_points = points
      part.total_time = time
      part.rank = rank
    end
  end

  def find_or_create_solutions(participation, tasks, row)
    tasks.each do |task|
      points, time = row[task.name].split == 1 ? [0, '00:00:00'] : row[task.name].split

      Solution.where(participation: participation, task: task).first_or_create do |sol|
        sol.points = points.to_i
        sol.time = time
      end
    end
  end

  def valid_date?
    return false if date.nil?

    Edition.not_deleted.where.not(id: id).pluck(:date).all? { |d| d.strftime('%Y-%m') != date.strftime('%Y-%m') }
  end

  def unique_month_and_year
    errors.add(:date, "can't be duplicated for month and year") unless valid_date?
  end
end
