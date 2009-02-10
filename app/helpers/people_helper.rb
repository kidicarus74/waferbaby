#
#	people_helper.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

module Merb
        module PeopleHelper
		
		def name_for_person(person)
			h(person.display_name.blank? ? person.username : person.display_name)
		end
		
		def link_to_person(person)
			link_to("#{icon_for_person(person)} #{name_for_person(person)}", url(:person, person), :title => "View more about '#{h(person.username)}'.")
		end
		
		def icon_for_person(person, width = 40, height = 40)
			image_tag("people/#{person.has_icon ? person.username : '_default'}.jpg", :width => width, :height => height, :alt => name_for_person(person), :class => 'icon')
		end
        end
end