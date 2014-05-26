require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

reply_stack_id = "stack_" + $my_options['gplus_reply']['stack_id']
message = "Comment from Vantage to Gplus " + Time.now.to_i.to_s

feature "Google+ Reply Test" do
    before do
        log_in_auto()
        click_link("social crm")
        expect(page).to have_content("Automated Parent Account Board")
        expect(page).to have_css(".stack")
    end

    scenario "Comment on a G+ Post" do
        find("##{reply_stack_id} > div.items > div:nth-child(1)").click
        expect(page).to have_content("Comment")
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".loading")
        end
        within(".vantage-modal-item-message-wrap") do
            find("div.actions > ul > li").click
        end
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".loading")
        end
        within(".simple-comment") do
            expect(page).to have_content("comment")
            find(".comment-message").set message
            find(".send-comment").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Comment Published")
        end
        # within(".vantage-modal-content") do
        #     expect(page).to have_content(message)
        # end
    end
end