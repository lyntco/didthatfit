OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1517537931811517', 'bdcda321ffa78f5d3c392e84aa757d5a'
end