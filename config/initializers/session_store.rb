# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_auth_app_session',
  :secret      => '3dab94fd88df0b3b73168c2528873740f7b277117a7eb62cf526403f6d317dabe381c6771f6ddea0f1d7fc9bdcd35551823498d1c579c3b6bf3931901803c2e8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
