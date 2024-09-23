class TodoController < ApplicationController
before_action :set_todo, only: [ :show, :update, :destroy ]

  # GET /todo?group_id
  def index
    @todos = ToDo.where(group_id: todo_params_index[:group_id]).select(:id, :title, :priority, :date_planning)
    json_response(@todos)
  end

  # GET /todo/:id
  def show
    json_response(@todo)
  end

  # POST /todo
  def create
    @todo = ToDo.create!(todo_params_create) # status: 0, date_creation: DateTime.now
    json_response(@todo, :created)
  end

  # PUT /todo/:id
  def update
    @todo.update(todo_params_update)
  end

  # DELETE /todo/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  # Helpers

  def todo_params_index
    params
      .permit(:group_id)
  end
  def todo_params_create
    params
      .permit(:group_id, :priority, :date_planning, :title, :description)
      .merge(date_creation: DateTime.now, status: 0)
  end
  def todo_params_update
    params
      .permit(:status, :group_id, :priority, :date_planning, :title, :description)
  end

  def set_todo
    @todo = ToDo.find(params[:id])
  end
end
