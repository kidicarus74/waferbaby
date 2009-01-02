Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
  resources :permissions
  resources :questions
  resources :answers
	# general routes.
	
        match('/about').to(:controller => 'help', :action => 'about').name(:about)
	match('/terms').to(:controller => 'help', :action => 'terms').name(:terms)
        match('/login').to(:controller => 'sessions', :action => 'new').name(:login)
        match('/logout').to(:controller => 'sessions', :action => 'destroy').name(:logout)
        match('/signup').to(:controller => 'people', :action => 'new').name(:signup)

	# special cases.

	match("/setup/:created_year(/:created_month(/:created_day))", :created_year => /^\d{4,}$/, :created_month => /^\d{2,}$/, :created_day => /^\d{2,}$/).to(:controller => 'interviews', :action => 'index_by_date')
	match("/wallscrawl/:created_year(/:created_month(/:created_day))", :created_year => /^\d{4,}$/, :created_month => /^\d{2,}$/, :created_day => /^\d{2,}$/).to(:controller => 'scrawls', :action => 'index_by_date')

	# flexible route for any index_by_date calls.

	match("/:controller/:created_year(/:created_month(/:created_day))", :created_year => /^\d{4,}$/, :created_month => /^\d{2,}$/, :created_day => /^\d{2,}$/).to(:action => 'index_by_date')	
	
	# for browsing people via a letter/number.
	
	match("/people/:character", :character => /^[A-Za-z0-9]$/).to(:controller => 'people', :action => 'index_by_letter_or_number')	

	# resource routes.
	
	identify Interview => [:created_year, :created_month, :created_day, :slug] do
		resources(:interviews, :path => 'setup')
	end
	
	identify Person => :username do
        	resources(:people)
	end

	identify Post => [:created_year, :created_month, :created_day, :slug] do
		resources(:posts) do |p|
			p.resources(:comments)
		end
	end

	identify Scrawl => [:created_year, :created_month, :created_day] do
        	resources(:scrawls, :path => 'wallscrawl')
	end
        
	# default.

        match('/').to(:controller => 'posts', :action => 'index').name(:default)
end