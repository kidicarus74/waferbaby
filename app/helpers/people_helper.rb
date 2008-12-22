#
# =>    people_helper.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

module Merb
        module PeopleHelper
		
		def name_for_person(person)
			h(person.display_name.blank? ? person.username : person.display_name)
		end
		
		def link_to_person(person)
			link_to(name_for_person(person), url(:person, person), :title => "View more about '#{h(person.username)}'.")
		end
        end
end