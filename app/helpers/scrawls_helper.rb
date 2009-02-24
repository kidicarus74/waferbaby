module Merb
	module ScrawlsHelper

		def link_to_scrawl(scrawl, title)
			link_to(title, url_for_scrawl(scrawl), :title => "Permalink for this scrawl.")  
		end
		
		def url_for_scrawl(scrawl)
			date_url_for(scrawl, 'wallscrawl') + "#at-#{scrawl.created_time}"
		end

	end
end