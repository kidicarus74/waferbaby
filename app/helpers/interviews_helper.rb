#
#	interviews_helper.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

module Merb
	module InterviewsHelper
		
		def icon_for_interview(interview, width = 40, height = 40)
			image_tag("setup/#{interview.slug}.thumb.jpg", :width => width, :height => height, :alt => h(interview.title), :class => 'icon')
		end
	end
end