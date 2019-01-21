source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.1'

gem 'rails', '~> 5.2.0'
group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg', '~> 0.18'
end
gem 'puma', '~> 3.11'
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'devise', '~> 4.5'
gem 'jwt', '~> 2.1.1', git: 'https://github.com/progrium/ruby-jwt.git'
gem 'rack-cors', '~> 1.0', '>= 1.0.2'
gem 'carrierwave', '~> 1.2', '>= 1.2.3'
gem 'carrierwave-aws', '~> 1.3'
gem 'mini_magick', '~> 4.9', '>= 4.9.2'
gem 'dotenv-rails', '~> 2.5'
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
