# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authorize, only: %i[edit update destroy]

  # GET /tasks
  def index
    @tasks = Task.paginate(page: params[:page])
  end

  # GET task/:id
  def show
  end

  # GET tasks/new
  def new
    @task = Task.new
  end

  # GET tasks/:id/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, success: 'Task was successfully created.'
    else
      flash[:warning] = helpers.error_messages(@task.errors)
      render action: :new
    end
  end

  # PUT|PATCH /tasks/:id
  def update
    if @task.update(task_params)
      redirect_to @task, success: 'Task was successfully updated.'
    else
      flash[:warning] = helpers.error_messages(@task.errors)
      render action: :edit
    end
  end

  # DELETE /editions/:id
  def destroy
    @task&.destroy
    flash[:success] = 'Task was successfully deleted.'
    redirect_to tasks_path
  end

  private

  def task_params
    params.required(:task).permit(:name, :author, :description, :edition_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
