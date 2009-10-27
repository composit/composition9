# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "prawn"
  config.gem "openrain-action_mailer_tls", :lib => "smtp_tls.rb", :source => "http://gems.github.com"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  STATE_NAMES = [
    [ "Alabama", "AL" ], 
    [ "Alaska", "AK" ], 
    [ "Arizona", "AZ" ], 
    [ "Arkansas", "AR" ], 
    [ "California", "CA" ], 
    [ "Colorado", "CO" ], 
    [ "Connecticut", "CT" ], 
    [ "Delaware", "DE" ], 
    [ "District Of Columbia", "DC" ], 
    [ "Florida", "FL" ], 
    [ "Georgia", "GA" ], 
    [ "Hawaii", "HI" ], 
    [ "Idaho", "ID" ], 
    [ "Illinois", "IL" ], 
    [ "Indiana", "IN" ], 
    [ "Iowa", "IA" ], 
    [ "Kansas", "KS" ], 
    [ "Kentucky", "KY" ], 
    [ "Louisiana", "LA" ], 
    [ "Maine", "ME" ], 
    [ "Maryland", "MD" ], 
    [ "Massachusetts", "MA" ], 
    [ "Michigan", "MI" ], 
    [ "Minnesota", "MN" ], 
    [ "Mississippi", "MS" ], 
    [ "Missouri", "MO" ], 
    [ "Montana", "MT" ], 
    [ "Nebraska", "NE" ], 
    [ "Nevada", "NV" ], 
    [ "New Hampshire", "NH" ], 
    [ "New Jersey", "NJ" ], 
    [ "New Mexico", "NM" ], 
    [ "New York", "NY" ], 
    [ "North Carolina", "NC" ], 
    [ "North Dakota", "ND" ], 
    [ "Ohio", "OH" ], 
    [ "Oklahoma", "OK" ], 
    [ "Oregon", "OR" ], 
    [ "Pennsylvania", "PA" ], 
    [ "Rhode Island", "RI" ], 
    [ "South Carolina", "SC" ], 
    [ "South Dakota", "SD" ], 
    [ "Tennessee", "TN" ], 
    [ "Texas", "TX" ], 
    [ "Utah", "UT" ], 
    [ "Vermont", "VT" ], 
    [ "Virginia", "VA" ], 
    [ "Washington", "WA" ], 
    [ "West Virginia", "WV" ], 
    [ "Wisconsin", "WI" ], 
    [ "Wyoming", "WY" ]
  ]
  WEEK_DOLLAR_ESTIMATE = 1450
  WEEK_HOUR_ESTIMATE = 55
end
