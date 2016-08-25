Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w(root.scss)
Rails.application.config.assets.precompile += %w(root.js)
Rails.application.config.assets.precompile += %w(users.scss)
Rails.application.config.assets.precompile += %w(about.scss)
Rails.application.config.assets.precompile += %w(about.js)
Rails.application.config.assets.precompile += ["*.ttf", "*.woff", "*.svg", "*.eot"] 
