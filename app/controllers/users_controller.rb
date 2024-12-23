class UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    @user = User.find_by!(email: "#{params[:id]}@thape.com.cn")
    @good_events = @user.good_events
    @bad_events = @user.bad_events
  end
end
