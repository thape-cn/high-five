class UsersController < ApplicationController
  def show
    @user = User.find_by!(email: "#{params[:id]}@thape.com.cn")
    set_meta_tags title: t(".title", name: @user.chinese_name)
    @good_events = @user.good_events
    @bad_events = @user.bad_events
  end
end
