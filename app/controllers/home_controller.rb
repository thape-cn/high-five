class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_brower, if: -> { request.format.html? }
  before_action :set_breadcrumbs, if: -> { request.format.html? }

  def index
    @first_level_user_job_roles = current_user&.user_job_roles || []
    @second_level_user_job_roles = []

    @first_level_user_job_roles.each do |ujr|
      ujr.managed_user_job_roles.each do |second_ujr|
        @second_level_user_job_roles << second_ujr if second_ujr.managed_user_job_roles.present?
      end
    end
  end

  protected

  def set_page_layout_data
    super
    @skip_title = true
  end

  private

  def set_breadcrumbs
    @_breadcrumbs = [
      {text: t("layouts.sidebars.application.header"),
       link: nil}
    ]
  end
end
