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
			link_to(name_for_person(person), url(:person, person), :title => "View more about '#{h(person.username)}'.")
		end
		
		def link_to_person_icon(person, width = 32, height = 32)
			link_to(icon_for_person(person, width, height), url(:person, person), :title => "View more about '#{h(person.username)}'.")
		end
		
		def icon_for_person(person, width = 32, height = 32)
			image_tag("people/#{person.username}.jpg", :width => width, :height => height, :alt => name_for_person(person))
		end
        end
end