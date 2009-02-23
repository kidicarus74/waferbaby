#
#	brainstorm.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Brainstorm

	include DataMapper::Resource
	include DataMapper::Timestamp

	property :id,		Serial
        property :uuid,         String, :length => 36
        property :slug,         String
        property :title,        String
        property :created_at,   DateTime
        property :updated_at,   DateTime

	is_paginated

	has n,                  :answers, :order => [:created_at.desc], :through => Resource

	validates_is_unique     :slug
        validates_present       :title

	before :save do
                self.uuid = UUID.generate
        end
end