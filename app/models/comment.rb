class Comment
        include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Integer, :serial => true
        property :uuid,         String, :length => 36
        property :contents,     Text
        property :created_at,   DateTime
        property :updated_at,   DateTime        
        
        belongs_to :person
        belongs_to :post

	validates_present       :contents
end
