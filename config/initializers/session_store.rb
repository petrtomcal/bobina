# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bobina_session',
  :secret      => 'a4af663054c73cdfb47da59d4125a60b4de672ae56150b81c0a4c76fb735fd6bbd5ff8c8aee8e0c578a4279ab1251ae7bc4e5e27a00e14c3f45c73b826344a4a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
