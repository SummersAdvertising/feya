source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'rake', '~> 10.4.2'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :production, :staging do
	gem 'mysql2'
end

group :development, :test do
	gem 'sqlite3'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'devise'
gem 'jquery-ui-rails'

gem "mini_magick"
gem 'carrierwave', "~> 0.9"

gem 'kaminari'

gem "remotipart"

gem 'delayed_job'
gem 'delayed_job_active_record'
gem 'daemons'


# gem 'therubyracer', "~> 0.11.4"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
#gem 'capistrano', group: :development
group :development  do
	gem "capistrano", "~> 3.4"
end

# To use debugger
# gem 'debugger'

gem 'rename'

gem 'awesome_nested_set'
