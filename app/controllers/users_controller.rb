class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_updated_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  def profile_updated
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :company_name, :company_url)
  end
end
