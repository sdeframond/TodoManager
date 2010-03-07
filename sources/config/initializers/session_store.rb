# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_todomanager_session',
  :secret      => '082067e177d54f20056cdb6e3de3a9ec07f5af44fb1ebeebd19c6a89af2a16ebce364b565cbd32cc0d3a2b377846767d391612a2486cfda5d290503776f140d2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
