class GroupController < ApplicationController
# skip_before_action :verify_authenticity_token
before_action :set_group, only: [:update, :destroy]

  # GET /group
  def index
    @groups = Group.all
    json_response(@groups)
  end

  # POST /group
  def create
    @group = Group.create!(group_params)
    json_response(@group, :created)
  end

  # PUT /group/:id
  def update
    @group.update(group_params)
    head :no_content
  end
  
  # DELETE /group/:id
  def destroy
    @group.destroy
    head :no_content
  end

  private

  def group_params
    params.permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
