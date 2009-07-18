# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_c9_session',
  :secret      => '963109e55aed4c61913e0f735ccf5b7581d098ea78f72d3eaa1d90c8e053d0c19163f89543bade4260930cdcb3a1dd586e337a56b6d0bf305fab215e3cb14323'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
