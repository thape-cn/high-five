class InfosController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    render json: {
      sso_enforced_for_signin: false,
      sso_enforced_for_signin_protocol: "oidc",
      sso_enforced_for_web: false,
      sso_enforced_for_web_protocol: "oidc",
      enable_marketplace: true,
      enable_email_code_login: true,
      enable_email_password_login: true,
      enable_social_oauth_login: false,
      is_allow_create_workspace: false,
      is_allow_register: false,
      is_email_setup: true,
      license: {
        status: "active",
        expired_at: ""
      },
      branding: {
        enabled: false,
        login_page_logo: "",
        workspace_logo: "",
        favicon: "",
        application_title: "THAPE Dify"
      },
      webapp_auth: {
        enabled: false,
        allow_sso: false,
        sso_config: {
          protocol: ""
        },
        allow_email_code_login: false,
        allow_email_password_login: false
      }
    }
  end
end
