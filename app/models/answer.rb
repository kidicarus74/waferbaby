#
#	answer.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Answer < Entry
	
	has 1,	:brainstorm, :through => Resource

end
