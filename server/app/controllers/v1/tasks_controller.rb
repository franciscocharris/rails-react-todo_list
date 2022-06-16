# frozen_string_literal: true

module V1
  class TasksController < ApplicationController
    before_action :find_task, except: %i[create index]

    def create
      @task = @current_user.tasks.new(task_params)
      @task.save!
      render json: { id: @task.id }, status: 201
    end

    def update
      # byebug
      @task.update!(task_params)
    end

    def destroy
      @task.destroy!
    end

    private

    def find_task
      @task = task.find(params[:id])
    end

    def task_params
      params.permit(:name, :description, :task_id)
    end
  end
end
