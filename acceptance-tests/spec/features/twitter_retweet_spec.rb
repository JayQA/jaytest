require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

edited_retweet = "I edited this retweet " + Time.now.asctime


feature "Twitter Retweet Test" do
    before do
        log_in_auto()
        click_link("social crm")
        expect(page).to have_content("scrm")
    end

    scenario "Retweet" do
        # find a tweet to use, yada yada yada, open the drawer
        # find(:xpath, '//*[@id="stack_' + $my_options['twitter_retweet']['stack_id'] + '"]/div[3]/div[1]/p').click
        find("#stack_" + $my_options['twitter_retweet']['stack_id'] + " > div.items > div:nth-child(1)").click
        within(".tweet-modal") do
            expect(page).to have_content("Retweet")
            find("#retweet-tweet").click
            expect(page).to have_content("Edit")
            find(".send-retweet").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Retweet published.")
        end
    end

    scenario "Edited Retweet" do
        # find(:xpath, '//*[@id="stack_' + $my_options['twitter_retweet']['stack_id'] + '"]/div[3]/div[1]/p').click
        find("#stack_" + $my_options['twitter_retweet']['stack_id'] + " > div.items > div:nth-child(1)").click
        within(".tweet-modal") do
            expect(page).to have_content("Retweet")
            find("#retweet-tweet").click
            expect(page).to have_content("Edit")
            find(".edit-retweet").click
            find(:xpath, '//*[@id="action-container"]/div/textarea').set edited_retweet
            find(".send-reply").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Tweet published.")
        end
    end

    scenario "Retweet a tweet in a conversation" do

        find("#stack_" + $my_options['twitter_retweet']['stack_id'] + " > div.items > div:nth-child(1)").click
        within(".vantage-modal-content") do
            find("#reply-tweet").click
            users = find(".reply-message").value
            find(".reply-message").set(users + " This is one interesting tweet.")
            find(".send-message").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Tweet published.")
            find(".close-modal.icon").click
        end
        within(all(".vantage-thread.twitter-replies.highlighted")[0]) do
            find(".message").hover
            find(".thread-retweet").click
        end
        within("#notifications") do
            page.should have_selector(".message", :text => "Retweet published.")
        end

    end

end