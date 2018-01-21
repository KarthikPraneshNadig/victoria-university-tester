module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
 
    def connect
      self.current_user = find_verified_user
    end
 
    protected
 
    def find_verified_user
      if (current_user = env['warden'].user)
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
# adding the connect method assigns the current user as an instance of a logged in user
# we access the user through warden (used by devise) and assigns to env warden all info about the session and authentication
# by calling env warden we get the current user 