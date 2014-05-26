require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Twitter Delete Test" do
    before do
        log_in_auto("mushroom")
        click_link("social crm")
        expect(page).to have_content("scrm")
    end

    scenario "Delete a Tweet" do
        find(:xpath, '//*[@id="stack_' + $my_options['twitter_delete']['stack_id'] + '"]/div[3]/div[5]').click
        message = find(:xpath, '//*[@id="stack_' + $my_options['twitter_delete']['stack_id'] + '"]/div[3]/div[5]/p[@class="message"]').text
        # puts message

        expect(page).to have_content("Reply")

        within(".vantage-modal-util") do
            find("#delete-tweet").click
        end

        within(".modal-content") do
            expect(page).to have_content("Are you sure you want to delete this tweet?")
            find(".button.warning.save-button").click
        end
        within(:xpath, '//*[@id="stack_' + $my_options['twitter_delete']['stack_id'] + '"]/div[3]/div[5]') do
            expect(page).to_not have_content(message)
        end
    end
end