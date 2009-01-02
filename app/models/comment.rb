#
# =>    comment.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class Comment
        include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Serial
        property :uuid,         String, :length => 36
        property :contents,     Text
        property :created_at,   DateTime
        property :updated_at,   DateTime        
        
        belongs_to :person
        has n,			:posts, :through => Resource

	is_paginated

	validates_present       :contents
	
	before :save do
		self.uuid = UUID.generate
	end
end