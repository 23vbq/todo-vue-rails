class TodoController < ApplicationController
before_action :set_todo, only: [ ]

  # test index
  def index
    @todos = ToDo.all
    json_response(@todos)
  end
  
  def create
    @todo = ToDo.create!(todo_params) # status: 0, date_creation: DateTime.now
    json_response(@todo, :created)
  end

  def todo_params
    params
      .permit(:group_id, :priority, :date_planning, :title, :description)
      .merge(date_creation: DateTime.now, status: 0)
  end
  def set_todo
    @todo = ToDo.find(params[:id])
  end
end
