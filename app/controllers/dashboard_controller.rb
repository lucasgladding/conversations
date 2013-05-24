class DashboardController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update]

  def index
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)
    if @conversation.save
      redirect_to edit_dashboard_path(@conversation)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @conversation.update(conversation_params)
      redirect_to edit_dashboard_path(@conversation)
    else
      render 'edit'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def conversation_params
    params.require(:conversation).permit(:topic,
      conversation_participants_attributes: [:id, :participant_id],
      messages_attributes: [:id, :content]
      )
  end

end
