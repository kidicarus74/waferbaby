#
# =>    application.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

require 'people_helper'

class Application < Merb::Controller
	protected
		def logged_in?
			current_person != :false
		end

		def current_person
			@current_person ||= (login_from_session || login_from_cookie || :false)
		end

		def current_person=(person)
			session[:person] = person.nil? ? nil : person.id
			@current_user = person
		end

		def login_from_session
			self.current_person = Person.get(session[:person]) if session[:person]
		end
		
		def login_from_cookie
			self.current_person = Person.first(:remember_token => cookies[:payload_of_love]) if cookies[:payload_of_love]
		end

		def login_required
			authorized? || throw(:halt, :access_denied)
		end
		
		def admin_required
			(logged_in? && current_person.has_permission(:admin)) || raise(NotFound)
		end

		def this_is_mine(item)
			item.person == current_person
		end

		def authorized?
			logged_in?
		end

		def access_denied
			session[:return_to] = request.uri
			redirect url(:login)
		end
end