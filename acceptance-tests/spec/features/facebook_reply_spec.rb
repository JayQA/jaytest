require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

message_comment = "Comment on a Facebook post from Vantage " + Time.now.to_i.to_s
message_reply = "Reply to a Facebook comment from Vantage " + Time.now.to_i.to_s
message_unpublished = "Reply to a Facebook Unpublished Post comment from Vantage " + Time.now.to_i.to_s

reply_stack_id_1 = "stack_" + $my_options['facebook_reply']['stackid_1']
reply_stack_id_2 = "stack_" + $my_options['facebook_reply']['stackid_2']

feature "Facebook Reply Test" do
    before do
        log_in_auto()
        click_link("social crm")
        expect(page).to have_content("Automated Parent Account Board")
        expect(page).to have_css(".stack")
    end

    scenario "Comment on a Facebook Post" do
        # Find a Facebook Item to open and comment on, and confirm that the message was successful
        find("##{reply_stack_id_1} > div.items > div:nth-child(1)").click
        expect(page).to have_content("Comment")

        within(".vantage-modal-item-message-wrap") do
            find("#facebook-comment").click
        end
        within("#action-container") do
            expect(page).to have_content("Submit")
            find(".reply-message").set message_comment
            find(".send-message").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Comment published.")
        end

        # Check that the comment immediately displays in the drawer
        within(".vantage-modal-content") do
            expect(page).to have_content(message_comment)
        end
=begin
        # Close and re-open the drawer to see if the message is still present
        sleep(5)
        within(".vantage-modal-nav") do
            find(".close-drawer").click
        end
        expect(page).to have_no_content("CONVERSATION")
        find(:xpath, '//*[@id="stack_' + $my_options['facebook_reply']['stack_id'] + '"]/div[3]/div[1]/a[3]').click
        expect(page).to have_content(message_comment)

        # Check to see if the comment has a Facebook ID associated with it
        element = page.find(".message", :text => message_comment).first(:xpath,".//../..")
        #puts "Element= " + element[:class].to_s
        expect(element["data-id"]).to_not be_nil
=end
    end

    scenario "Reply to a Facebook Comment" do
        within("##{reply_stack_id_1}") do
            expect(page).to have_css("div.items > div.item.facebook.fb-post > div.counts")
            all("div.items > div.item.facebook.fb-post > div.counts")[0].click
            # all(:xpath, '//*[@id="stack_' + $my_options['facebook_reply']['stackid_1'] + '"]//div[@class="counts"]')[0].click
        end

        within(".vantage-modal-content") do
            expect(page).to have_content("CONVERSATION")
        end
        within(".content.open.clearfix") do
            find("div:nth-child(1) > div.thread-box").hover
            # find(:xpath, '/html/body/div[9]/div/div/div[2]/div[2]/div/div[2]/div[1]/div[2]').hover
            find(".fb-reply").click
        end
        within(".modal-actions.simple-reply.clearfix") do
            expect(page).to have_content("Submit")
            find(".reply-message").set message_reply
            # find(:xpath, '/html/body/div[9]/div/div/div[2]/div[2]/div/div[2]/div[2]/textarea').set message_reply
            find(".send-message").click
        end

        within("#notifications") do
            page.should have_selector(".message", :text => "Comment published.")
        end

        within(".vantage-modal-content") do
            expect(page).to have_content(message_reply)
        end
    end

    scenario "Reply to a Facebook Unpublished Post Comment" do
        within("##{reply_stack_id_2}") do
            expect(page).to have_css("div.items > div.item.facebook.fb-post > div.counts")
            all("div.items > div.item.facebook.fb-post > div.counts")[0].click
            # all(:xpath, '//*[@id="stack_' + $my_options['facebook_reply']['stackid_2'] + '"]//div[@class="counts"]')[0].click
        end

        within(".vantage-modal-content") do
            expect(page).to have_content("CONVERSATION")
        end
        within(".content.open.clearfix") do
            find("div:nth-child(1) > div.thread-box").hover
            # find(:xpath, '/html/body/div[9]/div/div/div[2]/div[2]/div/div[2]/div[1]/div[2]').hover
            find(".fb-reply").click
        end
        within(".modal-actions.simple-reply.clearfix") do
            expect(page).to have_content("Submit")
            find(".reply-message").set message_unpublished
            # find(:xpath, '/html/body/div[9]/div/div/div[2]/div[2]/div/div[2]/div[2]/textarea').set message_unpublished
            find(".send-message").click
        end

        within("#notifications") do
            page.should have_selector(".message", :text => "Comment published.")
        end

        within(".vantage-modal-content") do
            expect(page).to have_content(message_unpublished)
        end

    end

end