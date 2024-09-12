class GroupController < ApplicationController
# skip_before_action :verify_authenticity_token
before_action :set_group, only: []

  def index
    @groups = Group.all
    json_response(@groups)
  end

  def create
    @group = Group.create!(group_params)
    json_response(@group,:created)
  end
end
