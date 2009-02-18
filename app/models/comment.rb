#
#	entry.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Comment < Entry
	
        has n,	:posts, :through => Resource

end