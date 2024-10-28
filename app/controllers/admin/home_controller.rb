module Admin
  class HomeController < BaseController
    before_action :check_brower, if: -> { request.format.html? }

    def index
      @job_family_data = JobRole.joins(:user_job_roles)
        .group(:job_family)
        .order("count(user_job_roles.user_id) desc")
        .limit(7)
        .count
    end

    protected

    def set_page_layout_data
      super
      @skip_title = true
    end
  end
end
