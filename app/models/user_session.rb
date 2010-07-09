class UserSession < Authlogic::Session::Base
  #logout_on_timeout true
  find_by_login_method :find_by_login_or_email
  generalize_credentials_error_messages "Invalid login credentials"
end