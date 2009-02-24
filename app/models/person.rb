#
#	person.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

require 'bcrypt'
require 'digest/sha1'

class Person
        include DataMapper::Resource
        include DataMapper::Timestamp
        include BCrypt

        property :id, 				Serial
        property :uuid, 			String, :length => 36
        property :old_crypted_password, 	String
        property :salt, 			String
        property :crypted_password, 		String, :length => 70
        property :username, 			String, :length => 2..40
	property :display_name,			String
        property :email_address, 		String, :format => :email_address
	property :remember_token,		String, :length => 70
	property :has_icon,			Boolean
	property :profile,			Text, :lazy => false
        property :created_at, 			DateTime
        property :updated_at, 			DateTime

	is_paginated

        validates_is_unique :username, :email_address
        validates_length :password, :in => 4..40, :if => :password_required?
	validates_length :display_name, :in => 2..30, :if => Proc.new { |p| !p.new_record? && !p.display_name.blank? }
        validates_is_confirmed :password, :groups => :create, :if => :password_required?
        validates_format :username, :as => /^([a-zA-Z0-9_]+)$/, :message => "Username can only contain letters, numbers or an underscore"
        
        has n, :comments
        has n, :posts
        has n, :scrawls
	
	has n, :entries, :order => [:created_at.desc], :class_name => 'Entry'
	has n, :permissions, :through => Resource
        
        attr_accessor :password, :password_confirmation
        
        before :save do
		self.uuid = UUID.generate
	end
	
        before :save, :encrypt_password
        
	def username
		u = attribute_get(:username)
		u.downcase! unless u.blank?
		
		u
	end
	
        def authenticated?(clear_password)
                # start migration code
                if self.old_crypted_password
                        
                        if self.old_crypted_password != Digest::SHA1.hexdigest("--#{self.salt}--#{clear_password}--")
                                return false
                        end
                        
                        self.password = clear_password
                        self.old_crypted_password = nil
                        
                        self.encrypt_password
                        self.save!
                end
                # end migration code

                Password.new(crypted_password) == clear_password
        end

	def remember_me
		self.remember_token = Digest::SHA1.hexdigest("#{uuid}-#{email_address}-#{created_at}-#{updated_at}-#{14.days.from_now}")
		self.save
	end
	
	def forget_me
		self.remember_token = nil
		self.save
	end
	
	def has_permission(permission_name)
		return false if self.permissions.empty?
		
		self.permissions.each do |permission|
			return true if permission.name == permission_name.to_s
		end
		
		false
	end

        protected
                def self.authenticate(username, clear_password)
                        person = first(:username => username)
                        person && person.authenticated?(clear_password) ? person : nil
                end

                def password_required?
                        self.crypted_password.blank? || !self.password.blank?
                end
                
                def encrypt_password
                        self.crypted_password = Password.create(self.password) unless self.password.blank?
                end                
end