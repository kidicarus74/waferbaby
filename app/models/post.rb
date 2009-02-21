#
#	post.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

require 'iconv'

class Post
        include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Serial
        property :uuid,         String, :length => 36
        property :slug,         String
        property :title,        String
        property :contents,     Text, :lazy => false
        property :created_at,   DateTime
        property :updated_at,   DateTime

	is_paginated
        
        has n,                  :categories, :through => Resource
        has n,                  :comments, :through => Resource
        
        validates_is_unique     :slug
        validates_present       :title, :contents
        
        attr_accessor           :is_selected
        
        before :save do
                if new_record?
                        self.uuid = UUID.generate
                        self.slug = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', self.title).to_s

                        self.slug.gsub!(/\W+/, ' ')
                        self.slug.strip!
                        self.slug.downcase!
                        self.slug.gsub!(/\s+/, '-')
                end
        end
end
