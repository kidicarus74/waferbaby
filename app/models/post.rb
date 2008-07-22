require 'iconv'

class Post
        include DataMapper::Resource
        include DataMapper::Timestamp
        
        property :id,           Integer, :serial => true
        property :slug,         String
        property :title,        String
        property :contents,     Text
        property :created_on,   DateTime
        property :updated_on,   DateTime
        
        has n,                  :categories, :through => Resource
        
        validates_present       :title
        validates_present       :contents
        validates_is_unique     :slug
        
        attr_accessor           :is_selected

        before :save do
                if new_record?
                        self.slug = Iconv.iconv('ascii//translit//IGNORE', 'utf-8', self.title).to_s
                        
                        self.slug.gsub!(/\W+/, ' ')
                        self.slug.strip!
                        self.slug.downcase!
                        self.slug.gsub!(/\s+/, '-')
                end
        end        
end
