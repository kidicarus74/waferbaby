#
# =>    post.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

require 'iconv'

class Post
        include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Integer, :serial => true
        property :slug,         String
        property :title,        String
        property :contents,     Text, :lazy => false
        property :type,         Discriminator
        property :created_at,   DateTime
        property :updated_at,   DateTime
        
        has n,                  :categories, :through => Resource
        has n,                  :comments, :through => Resource
        
        validates_present       :contents
        
        attr_accessor           :is_selected
end
