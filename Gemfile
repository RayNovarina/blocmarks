source 'https://rubygems.org'

ruby '2.2.4'

#========== GLOBAL GEMS ======================
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Use jquery turbolinks for bootstrap dropdown picklist
gem 'jquery-turbolinks'
# Use Devise authentication
gem 'devise'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Twitter Bootstrap as CSS framework
gem 'bootstrap-sass'

# Use Figaro to store Sendgrid and Devise credentials as environment variables.
#     Doc - Bloc: https://www.bloc.io/resources/environment-variables-with-figaro
#     GitHub - https://github.com/laserlemon/figaro#give-me-an-example
gem 'figaro', '1.0'

#============== DEVELOPMENT only GEMS =================
group :development do
  # Use sqlite3 as the SQL db server for Active Record in development/local OSX
  # machine.
  gem 'sqlite3'
  # Use Pry as alternative Rails console shell (alternative to IRB)
  # To use: add    " require 'pry' " at head of file.
  #         insert " binding.pry " in the code to where you want the breakpoint.
  gem 'pry-rails'
end

#============ DEVELOPMENT, TEST only GEMS =============
group :development, :test do
  # Use Rspec for TDD.
  gem 'rspec-rails', '~> 3.0'
  # Rspec extension that add "shoulda" test syntax.
  # To use: ??
  gem 'shoulda'
  # Rspec extension to generate Factory objects for tests.
  # gem 'factory_girl_rails', '~> 4.0'
end

#=========== PRODUCTION only GEMS =================
group :production do
  # use postgre SQL db server for Active Record in production (Heroku)
  # deployment
  gem 'pg'
  # Rails 4 requires some minor configuration changes to properly serve assets
  # on Heroku
  gem 'rails_12factor'
end
