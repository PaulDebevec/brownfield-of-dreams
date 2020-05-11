Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_CLIENT_ID_1'], ENV['GITHUB_CLIENT_SECRET_1']
end
