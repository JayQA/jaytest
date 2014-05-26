module Vantage

	# boards

	def select_board(board)
		within('#toolbar-title') do
			find("a", :text => board).click
		end
	end

	def new_board(board)
		find('.create-board').click()
		find('.new-board>input').set(board)
		find('#stacks').click()
		expect(page).to have_content board

	end

	def delete_board(board)
		within('#toolbar-title') do
			find("a", :text => board).hover
			sleep 2
        	find(".board-delete").click
        end
        expect(page).to have_content("Delete Board?")
        find('.save-button.button.warning').click()
        expect(page).to have_no_content board
        sleep 3
	end

	# stacks

	def new_stack(options = {})

		network = options[:network]
		account = options[:account]
		stream = options[:stream]
		search = options[:search]

		#twitter options
		term = options[:terms]
		list = options[:lists]

		# start stack creation

		within('#stacks') do
			find('.make-new-stack').click
		end

		# stack type selection

		within(".vantage-config-stack-type-container") do
			find(".select2-arrow").click
		end

		within(".vantage-config-stack-type-dropdown") do
				find("li", :text => network).click
		end

		# account selection

		within(".vantage-config-account-container") do
			find(".select2-arrow").click
		end

		within(".vantage-config-account-dropdown") do
				find("li", :text => account).click
		end

		#stream selection

		within(".vantage-config-stream-type-container") do
			find(".select2-arrow").click
		end

		within(".vantage-config-stream-type-dropdown") do
				find("li", :text => stream).click
		end

		# stream Search and List check

		if stream == "Search"

			within(".stream-option-block-input") do
				find(".text-entry").set search
			end

			if term
				within(".vantage-config-search-terms-container") do
					find(".select2-arrow").click
				end

				within(".vantage-config-search-terms-dropdown") do
					find("li", :text => term).click
				end
			end
					

		elsif stream == "List"

			within(".vantage-config-lists-container") do
				find(".select2-arrow").click
			end

			within(".vantage-config-lists-dropdown") do
				find("li", :text => list).click
			end


		end

		# save stack

		within(".config-footer") do
			find(".config-save-txt").click
		end

		

	end

end






