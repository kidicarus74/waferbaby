#
#	entry.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Comment < Entry
	
        has 1, :post, :through => Resource

end