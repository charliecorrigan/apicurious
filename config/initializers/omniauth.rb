Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'], scope: "user,repo,gist"
end

# use OmniAuth::Builder do
  # provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
# end