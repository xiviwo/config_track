# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_track_session',
  :secret      => 'd11a736258699d9de810e9c7850c8123907a49a2db8673e86a8e6fb66e303efa8f5c54c9421c37170514945aacc15eb1f20c98be6d9d3a1f1afc0ea26e363989'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
