class FrontController < ApplicationController
  before_action :set_conversation, only: [:edit, :update, :create_message]

  before_filter :authorize_participant, only: [:edit, :update, :create_message]

  def index
  end

  def new
    @conversation = Conversation.new
  end

  def edit
    @message = Message.new
    @conversation.mark_unread_for_user(current_user, false)
  end

  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.creator = current_user
    @conversation.append_participant(current_user)

    participant = User.find_by_username(params[:participant])
    @conversation.append_participant(participant)

    if @conversation.save
      redirect_to edit_front_url(@conversation)
    else
      render 'new'
    end
  end

  def update
    if @conversation.update_attributes(conversation_params)
      redirect_to edit_front_url(@conversation)
    else
      render 'edit'
    end
  end

  def create_message
    @message = Message.new(message_params)
    @message.conversation = @conversation
    @message.user = current_user

    @conversation.mark_unread(true)

    if @message.save
      redirect_to edit_front_url(@conversation)
    else
      render 'edit'
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  def authorize_participant
    conversation = Conversation.find(params[:id])
    unless conversation.has_participant?(current_user)
      redirect_to front_index_url, alert: 'You are not participating in this conversation.'
    end
  end

  def conversation_params
    params.require(:conversation).permit(:id, :topic)
  end

  def message_params
    params.require(:message).permit(:content)
  end

end
