class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :update_avatar]
  skip_before_action :verify_authenticity_token

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def update_avatar
    if @user.update(avatar_params)
      render json: {avatarUrl: url_for(@user.avatar)}
    else
      render json: @user.errors, status: :unprocessable_entity
    end  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :age, :name, :password, :password_confirmation)
    end

    def avatar_params
      params.permit(:avatar)
    end
end
