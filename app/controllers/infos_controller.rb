class InfosController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    render json: {
      sso_enforced_for_signin: false,
      sso_enforced_for_signin_protocol: "oidc",
      sso_enforced_for_web: false,
      sso_enforced_for_web_protocol: "oidc",
      enable_email_code_login: true,
      enable_email_password_login: true,
      enable_social_oauth_login: false,
      is_allow_register: false,
      is_allow_create_workspace: false,
      is_email_setup: true,
      license: {
        status: "active",
        expired_at: ""
      }
    }
  end
end
