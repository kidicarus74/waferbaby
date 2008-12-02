#
# =>    global_helper.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

module Merb
        module GlobalHelpers
                include Merb::PeopleHelper
                
                def markup(string)
                        markdown = RDiscount.new(string)
                        
                        markdown.filter_html = true
                        markdown.filter_styles = true
                        
                        markdown.to_html
                end
                
                def display_errors_for(object, error_class='errors')
                        return if object.errors.length < 1
                        
                        messages = "\n", object.errors.full_messages.collect { |message| tag('li', message) }.join("\n"), "\n"                        
                        tag('ul', messages, :class => error_class)
                end

		def summary(str)
			str.slice(/^(.+)\n\n/).strip
		end
		
		def session_message
			message = session[:message]
			session[:message] = nil
			
			message
		end
                
		def date_title
			dt = Time.utc(params["created_year"], params["created_month"], params["created_day"])
			
			if params["created_day"]
				result = dt.strftime("%B %d, %Y")
			elsif params["created_month"]
				result = dt.strftime("%B %Y")
			else
				result = dt.strftime("%Y")
			end
			
			result
		end
		
                def date_url_for(object, prefix)
                        "/#{prefix}/#{object.created_year}/#{object.created_month}/#{object.created_day}"
                end
        end
end
