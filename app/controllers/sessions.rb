#
# =>    sessions.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class Sessions < Application
        def new
                if request.post?
			if params[:username].blank? || params[:password].blank?
				session[:message] = "We need both your username and password!"
			else
	                        self.current_person = Person.authenticate(params[:username], params[:password])
	                        if logged_in?
					if params[:remember_me]
						self.current_person.remember_me
						cookies.set_cookie(:payload_of_love, self.current_person.remember_token, :path => '/', :expires => 14.days.from_now, :domain => '.waferbaby.com')
					end
		
	                                url = session[:return_to] || "/"
	                                session[:return_to] = nil
	                                redirect(url)
				else
					session[:message] = "Your username or password seems to be wrong. Try again?"
	                        end
			end
                end
                
                render
        end

        def destroy
		self.current_person.forget_me if logged_in?
		cookies.delete(:payload_of_love)
		
                session.clear!
                redirect("/") 
        end
end