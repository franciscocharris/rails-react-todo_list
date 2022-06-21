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
      @task.update!(task_params)
    end

    def destroy
      @task.destroy!
    end

    private

    def find_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.permit(:id, :name, :description, :list_id)
    end
  end
end
