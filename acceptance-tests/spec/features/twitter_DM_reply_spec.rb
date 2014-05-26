require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Helper

message = "Direct message reply sent from Vantage " + Time.now.asctime

feature "Twitter Direct Message Reply Test" do
    before do
        log_in_auto()
        main_nav_scrm()
    end

    # scenario "Reply to a Direct Message" do
    #     find("#stack_7107 > div.items > div:nth-child(1)").click
    #     within(".vantage-modal-content") do
    #         expect(page).to have_no_css(".loading")
    #     end
    #     within("#action-container") do
    #         expect(page).to have_content("Submit")
    #         find(".reply-message").set message
    #         find(".send-message").click
    #         find(".close-action").click
    #     end
    #     within(".vantage-modal-content") do
    #         expect(page).to have_no_css(".loading")
    #     end
    #     within("#notifications") do
    #         expect(page).to have_selector(".message", :text => "Direct message sent.")
    #     end
    #     within("#thread-container") do
    #         expect(page).to have_content(message)
    #     end
    # end

    scenario "Send a DM from the context menu of a tweet in the drawer" do
        # expect(page).to have_no_css("#stack_" + $my_options['twitter_reply']['stack_id'] + ".stack.loading")
        find("a.board-name", :text => "Twitter").click
        expect(page).to have_css"#stack_7635"
        expect(page).to have_no_css("#stack_7635.stack.loading")
        within("#stack_7635.stack") do
            all("div.items > div.item.twitter > div.username", :text => "@twitbashpro")[0].click
            # page.execute_script("window.scroll(200000,0)")
        end
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".loading")
            find(".dropdown.vantage-dropdown > a.icon").click
            expect(page).to have_no_css(".loading")
            find("#direct-message").click
        end
        within("#action-container") do
            expect(page).to have_content("Submit")
            find(".reply-message").set("Second DM reply test" + Time.now.to_i.to_s)
            find("a", :text => "Submit").click
            # find(".close-action").click
        end
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".loading")
        end
        within("#notifications") do
            expect(page).to have_selector(".message", :text => "Direct message sent.")
        end
    end
end
