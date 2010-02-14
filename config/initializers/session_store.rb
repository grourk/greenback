# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_greenback_session',
  :secret => '60314cc0015978444ca7224a7b965481e6e4492daa5b52851a5b70198219ba3bd85ac4e0ec0bc76d6552e6f9cd34618d9f99389807ec94a909db62f17793b75c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
