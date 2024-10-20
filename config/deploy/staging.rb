set :application, "high_five"
set :repo_url, "https://git.thape.com.cn/rails/high-five.git"
set :nginx_use_ssl, true
set :rails_env, "production"
set :puma_service_unit_name, :puma_rails_starter
set :puma_systemctl_user, :system

server "bandwagon", user: "high_five", roles: %w[app db web]
