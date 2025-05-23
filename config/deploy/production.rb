set :application, "high_five"
set :repo_url, "https://git.thape.com.cn/rails/high-five.git"
set :nginx_use_ssl, true
set :rails_env, "production"
set :puma_service_unit_name, :puma_high_five
set :puma_systemctl_user, :system
set :sidekiq_service_unit_name, "sidekiq_high_five"

server "thape_ai", user: "high_five", roles: %w[app db web worker]
