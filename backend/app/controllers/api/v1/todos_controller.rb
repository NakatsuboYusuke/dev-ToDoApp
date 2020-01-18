module Api::V1
  class TodosController < ApplicationController
    before_action :set_todo, only: [:destroy]

    def create
     @todo = Todo.new(todo_params)

      if @todo.save
        render json: @todo, status: :created
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @todo.destroy
    end

    private
    def set_todo
      @todo = Todo.find(params[:id])
    end

    def todo_params
      params.require(:todo).permit(:title, :user_id)
    end
  end
end
