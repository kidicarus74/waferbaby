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
        belongs_to :post

	is_paginated

	validates_present       :contents
end
