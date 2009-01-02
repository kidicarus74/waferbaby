#
#	scrawl.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Scrawl
        include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Serial
        property :uuid,         String, :length => 36
        property :contents,     Text
        property :created_at,   DateTime
        property :updated_at,   DateTime
        
	is_paginated

        belongs_to :person
        
        validates_present       :contents
        
        before :save do
                self.uuid = UUID.generate
        end
end
