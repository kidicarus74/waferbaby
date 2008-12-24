dependency 'rdiscount'
dependency 'uuid'

dependency 'merb-action-args'
dependency 'merb-assets'
dependency 'merb-helpers'
dependency 'merb-param-protection'
dependency 'merb_jquery'
dependency 'merb-pagination'
 
dependency 'dm-core'
dependency 'dm-aggregates'
dependency 'dm-migrations'
dependency 'dm-timestamps'
dependency 'dm-validations'
dependency 'dm-is-paginated'

require 'lib/timestamp_extensions'

use_orm                         :datamapper
use_test                        :rspec
use_template_engine             :haml

Merb::Config.use do |c|
        c[:session_secret_key]  = '1703bf9efcbb694541de2ce7c48b9406da71ac00'
        c[:session_store]       = 'datamapper'
end

Merb::BootLoader.before_app_loads do
        Merb.add_mime_type(:atom, :to_atom, %w[application/atom+xml])
end