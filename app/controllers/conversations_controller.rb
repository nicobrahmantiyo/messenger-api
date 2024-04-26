class ConversationsController < ApplicationController
    before_action :set_conversation, only: [:show, :update, :destroy]

  # GET /conversations
  def index
    @conversations = Conversation.all
    render json: @conversations
  end

  # GET /conversations/:id
  def show
    render json: @conversation
  end

  # POST /conversations
  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      render json: { message: "Conversation created", conversation: @conversation }, status: :created
    else
      render json: { errors: @conversation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT/PATCH /conversations/:id
  def update
    if @conversation.update(conversation_params)
      render json: { message: "Conversation updated", conversation: @conversation }
    else
      render json: { errors: @conversation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/:id
  def destroy
    if @conversation
      @conversation.destroy
      render json: { message: "Conversation deleted" }, status: :no_content
    else
      render json: { error: "Conversation not found" }, status: :not_found
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:id])
    render json: { error: "Conversation not found" }, status: :not_found unless @conversation
  end

  def conversation_params
    params.require(:conversation).permit(:name, :user_id)  # Sesuaikan dengan parameter yang ingin diperbolehkan
  end

end
