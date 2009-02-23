#
#	interview.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Interview

	include DataMapper::Resource
	include DataMapper::Timestamp

	property :id, 		Serial
        property :uuid,         String, :length => 36
        property :slug,         String
        property :title,        String
	property :summary,	String
	property :credits,	String, :length => 100
	property :contents,	Text
        property :created_at,   DateTime
        property :updated_at,   DateTime

	is_paginated
	
	validates_is_unique     :slug
        validates_present       :title, :contents

	before :save do
                self.uuid = UUID.generate
        end
end