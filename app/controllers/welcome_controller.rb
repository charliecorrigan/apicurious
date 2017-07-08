class WelcomeController < ApplicationController
  def index
    if current_user
      @user = current_user
      @user.load_root_data
    end
  end
end
