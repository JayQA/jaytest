require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

reply_tweet = " Tweet reply sent from Vantage " + Time.now.asctime
thread_reply = " Reply to a Vantage thread item " + Time.now.asctime

feature "Twitter Reply Test" do
    before do
        log_in_auto("mushroom")
        click_link("social crm")
        expect(page).to have_content("scrm")
    end

    scenario "Reply to a Tweet in the stack" do
        find("#stack_" + $my_options['twitter_reply']['stack_id'] + " > div.items > div:nth-child(1)").click
        username = find(:xpath, '//*[@id="stack_' + $my_options['twitter_reply']['stack_id'] + '"]/div[3]/div[1]/div[@class="username"]').text

        within(".tweet-modal") do
            expect(page).to have_content("Reply")
            find("#reply-tweet").click
        end
        within("#action-container") do
            expect(page).to have_content("Submit")
            find(:xpath, '//*[@id="action-container"]/div/textarea').set username + reply_tweet
            find(".send-message").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Tweet published.")
        end
        #within(".vantage-modal-content") do
        #   expect(page).to have_content(reply_tweet)
        #end
    end

    scenario "Reply to a Tweet in a conversation thread" do
        sleep(5)
        find("#stack_" + $my_options['twitter_reply']['stack_id'] + " > div.items > div:nth-child(1)").click
        username = find(:xpath, '//*[@id="stack_' + $my_options['twitter_reply']['stack_id'] + '"]/div[3]/div[1]/div[@class="username"]').text

        within(".vantage-modal-content") do
            expect(page).to have_content("CONVERSATION")
        end
        within(".content.open.clearfix") do
            find(:xpath, '/html/body/div[9]/div/div[2]/div[2]/div/div[2]/div[1]/div[1]/div[2]').hover
            find(".thread-reply").click
        end
        within(".modal-actions.simple-reply.clearfix") do
            expect(page).to have_content("Submit")
            find(:xpath, '/html/body/div[9]/div/div[2]/div[2]/div/div[2]/div[2]/textarea').set username + thread_reply
            find(".send-message").click
        end

        within("#notifications") do
            page.should have_selector(".message", :text => "Tweet published.")
        end

    end

end