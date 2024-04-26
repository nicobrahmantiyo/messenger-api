class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
    def index
        @users = User.select(:id, :name, :email, :photo_url, :created_at, :updated_at)
        render json: @users
    end
      
  

  # GET /users/:id
  def show
    @user = User.find_by(id: params[:id])
    if @user
      render json: @user
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/:id
  def update
    if @user.update(user_params)
        render json: @user
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
  end

  # DELETE /users/:id
  def destroy
    if @user
      @user.destroy
      head :no_content
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
  

  private

  def set_user
    @user = User.find_by(id: params[:id])
    render json: { error: "User not found" }, status: :not_found unless @user
end

  def user_params
    params.require(:user).permit(:name, :email, :password, :photo_url)
  end
   
end
