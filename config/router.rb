Merb.logger.info("Compiling routes...")
Merb::Router.prepare do
        match('/about').to(:controller => 'help', :action => 'show_about').name(:about)
        match('/login').to(:controller => 'sessions', :action => 'new').name(:login)
        match('/logout').to(:controller => 'sessions', :action => 'destroy').name(:logout)
        match('/signup').to(:controller => 'people', :action => 'new').name(:signup)

        match(%r'/([a-z]+)/([0-9]{4,})/([0-9]{2,})/([0-9]{2,})').to(:controller => '[1]', :action => 'index_by_date', :created_year => '[2]', :created_month => '[3]', :created_day => '[4]')
        match(%r'/([a-z]+)/([0-9]{4,})/([0-9]{2,})').to(:controller => '[1]', :action => 'index_by_date', :created_year => '[2]', :created_month => '[3]')
        match(%r'/([a-z]+)/([0-9]{4,})').to(:controller => '[1]', :action => 'index_by_date', :created_year => '[2]')
        
	identify Person => :username do
        	resources(:people)
	end

	identify Post => [:created_year, :created_month, :created_day, :slug] do
		resources(:posts)
	end

	identify Scrawl => [:created_year, :created_month, :created_day] do
        	resources(:scrawls)
	end
        
        match('/').to(:controller => 'posts', :action => 'index').name(:default)
end