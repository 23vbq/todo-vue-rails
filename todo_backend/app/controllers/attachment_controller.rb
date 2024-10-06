class AttachmentController < ApplicationController
before_action :set_attachment, only: [ :show, :update, :destroy ]

  # GET /attachment?to_do_id
  def index
    @attachments = Attachment.where(to_do_id: attachment_params_index[:to_do_id]).select(:id, :name)
    json_response(@attachments)
  end

  # GET /attachment/:id
  def show
    json_response(@attachment)
  end

  # POST /attachment
  def create
    @attachment = Attachment.create!(attachment_params_create)
    json_response(@attachment, :created)
  end

  # PUT /attachment/:id
  def update
    @attachment.update(attachment_params_update)
  end

  # DELETE /attachment/:id
  def destroy
    @attachment.destroy
    head :no_content
  end

  # Helpers

  def attachment_params_index
    params
      .permit(:to_do_id)
  end
  def attachment_params_create
    params
      .permit(:to_do_id, :name, :data)
  end
  def attachment_params_update
    params
      .permit(:name)
  end

  def set_attachment
      @attachment = Attachment.find(params[:id])
  end
end
