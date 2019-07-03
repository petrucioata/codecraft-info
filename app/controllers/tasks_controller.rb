# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destory]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destory
  end

  private

  def task_params
    params.required(:task).permit(name, author, description, edition_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
