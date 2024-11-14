class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :check_brower, if: -> { request.format.html? }
  before_action :set_breadcrumbs, if: -> { request.format.html? }

  def index
    @first_level_user_job_roles = current_user&.user_job_roles || []
    @second_level_user_job_roles = @first_level_user_job_roles.flat_map do |user_job_role|
      user_job_role.managed_user_job_roles.select(&:managed_user_job_roles)
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
