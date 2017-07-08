class UsersController < ApplicationController
  def show
    @user = current_user
    @user.load_profile_data
  end
end