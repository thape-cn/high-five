Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "staging-bpm.thape.com.cn:1000", "bpm.thape.com.cn:1000", "bpmmobiletest.thape.com.cn", "bpmmobile.thape.com.cn", "localhost:3000"

    resource "/api/*",
      headers: :any,
      methods: %i[get post put patch delete options head],
      credentials: true
  end
end
