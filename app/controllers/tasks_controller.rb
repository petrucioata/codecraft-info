# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destory]

  # GET /tasks
  def index
    @tasks = Task.all
  end

  def show
  end

  # GET tasks/new
  def new
    @task = Task.new
  end

  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render action: :new
    end
  end

  def update
  end

  def destory
  end

  private

  def task_params
    params.required(:task).permit(:name, :author, :description, :edition_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
