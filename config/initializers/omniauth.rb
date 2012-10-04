OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '269107753180877', '6b44649e530c3fd1b6efdfc993c7fb05'
end