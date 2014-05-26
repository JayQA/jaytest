require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

reply_stack_id = "stack_" + $my_options['instagram_reply']['stack_id']
message = "I just need to comment on this lovely image from Vantage " + Time.now.to_i.to_s

feature "Instagram Reply Test" do
    before do
        log_in_auto()
        click_link("social crm")
        expect(page).to have_content("Automated Parent Account Board")
    end

    scenario "Comment on an Instagram Post" do
        find("##{reply_stack_id} > div.items > div:nth-child(1)").click
        expect(page).to have_content("comment")
        sleep(1)
        within(".vantage-modal-item-message-wrap") do
            find("div.actions > ul > li:nth-child(2)").click
        end
        within(".simple-comment") do
            expect(page).to have_content("comment")
            find(".comment-message").set message
            find(".send-comment").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Comment Published")
        end
        # This feature isn't ready for Instagram yet
        #within(".vantage-modal-content") do
        #   expect(page).to have_content(message)
        #end
    end
end
