#
#	comment.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Entry

	include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Serial
        property :uuid,         String, :length => 36
	property :type,		Discriminator
        property :contents,     Text, :lazy => false
        property :created_at,   DateTime
        property :updated_at,   DateTime        
        
        belongs_to :person

	is_paginated

	validates_present       :contents
	
	before :save do
		self.uuid = UUID.generate
	end
	
end
