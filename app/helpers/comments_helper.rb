module Merb
	module CommentsHelper
		
		def link_to_comment(comment, title)
			link_to(title, url_for_comment(comment), :title => "Permalink for this comment.")
		end
		
		def url_for_comment(comment)
			url(:post, comment.post[0]) + "#comment-at-#{comment.created_time}"
		end
		
	end
end