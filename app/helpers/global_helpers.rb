#
#	global_helper.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

module Merb
	module GlobalHelpers
		include Merb::PeopleHelper

		def markup(string, filter_html = true, filter_styles = true)
			markdown = RDiscount.new(string)

			markdown.filter_html = filter_html
			markdown.filter_styles = filter_styles

			markdown.to_html
		end

		def display_errors_for(object)
			return if object.errors.length < 1

			messages = "\n", object.errors.full_messages.collect { |message| tag('li', message) }.join("\n"), "\n"                        
			tag('ul', messages, :id => 'message')
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
