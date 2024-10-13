class UsersController < ApplicationController

  skip_before_action :authorized, only: [:create]


  def create
    @user = User.create(user_params)

    if @user.valid?
      token = encode_token( {user_id: @user.id} )
      render json: {user: @user, token:token}, status: :ok
    else
      render json: { status: 'error', message: @user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def profile
    render json: user
  end

private

def user_params
     params.require(:user).permit(:username, :password, :email, :password_confirmation)
end
end
