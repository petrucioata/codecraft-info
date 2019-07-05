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

  def import_csv(file)
    rows = CSV.read(file.path, headers: true)
    tasks = find_or_create_tasks(rows.headers[2..4])

    rows.each do |row|
      participant = Participant.where(username: row['username']).first_or_create
      participation = find_or_create_participation(participant, row['points'], row['total_time'])
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

  def find_or_create_participation(participant, points, time)
    Participation.where(participant: participant, edition: self).first_or_create do |part|
      part.total_points = points
      part.total_time = time
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
end
