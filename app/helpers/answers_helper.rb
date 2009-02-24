module Merb
	module AnswersHelper

		def link_to_answer(answer, title)
			link_to(title, url_for_answer(answer), :title => "Permalink for this answer.")
		end
		
		def url_for_answer(answer)
			url(:brainstorm, answer.brainstorm[0]) + "#answer-at-#{answer.created_time}"
		end

	end
end