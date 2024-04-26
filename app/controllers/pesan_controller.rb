class PesanController < ApplicationController
        before_action :set_pesan, only: [:show, :update, :destroy]
        before_action :set_conversation, only: [:create]
      
        
        def index
          @pesan = Pesan.all
          render json: @pesan
        end
      
        
        def show
          render json: @pesan
        end
      
        
        def create
          @pesan = @conversation.pesan.build(pesan_params)  
      
          if @pesan.save
            render json: { pesan: "Pesan sukses", pesan_data: @pesan }, status: :created
          else
            render json: { errors: @pesan.errors.full_pesan }, status: :unprocessable_entity
          end
        end
      
        
        def update
          if @pesan.update(pesan_params)
            render json: { pesan: "Pesan updated", pesan_data: @pesan }
          else
            render json: { errors: @pesan.errors.full_pesan }, status: :unprocessable_entity
          end
        end
      
        
        def destroy
          if @pesan
            @pesan.destroy
            render json: { pesan: "Pesan dihapus" }, status: :no_content
          else
            render json: { error: "Pesan tidak ada" }, status: :not_found
          end
        end
      
        private
      
        def set_pesan
          @pesan = Pesan.find_by(id: params[:id])
          render json: { error: "Pesan not found" }, status: :not_found unless @pesan
        end
      
        def set_conversation
          @conversation = Conversation.find_by(id: params[:conversation_id])
          render json: { error: "Conversation not found" }, status: :not_found unless @conversation
        end
      
        def pesan_params
          params.require(:pesan).permit(:text, :user_id, :conversation_id)  
        end

      
end
