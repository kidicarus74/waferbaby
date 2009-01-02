class Permission
	include DataMapper::Resource

	property :id, 		Serial
	property :uuid,		String, :length => 36
	property :name,		String
	property :created_at, 	DateTime
	property :updated_at, 	DateTime
	
	has n, :people, :through => Resource
	
	before :save do
		self.uuid = UUID.generate
	end

end