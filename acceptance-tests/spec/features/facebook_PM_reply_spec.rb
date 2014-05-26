require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav

message = "Private message reply from Vantage " + Time.now.to_i.to_s

feature "Facebook Private Message Reply Test" do
    before do
        log_in_auto()
        main_nav_scrm
    end

    scenario "Reply to a Facebook Private Message" do
        find("#stack_7106 > div.items > div:nth-child(1)").click
        expect(page).to have_content("private message")
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".loading")
        end
        within("#action-container") do
            expect(page).to have_content("Submit")
            find(".reply-message").set message
            #find(:xpath, '//*[@id="action-container"]/div/textarea').set message
            find(".send-message").click
            find(".close-action").click
        end
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".loading")
        end
        within("#notifications") do
            expect(page).to have_selector(".message", :text => "Private message sent.")
        end
        within("#thread-container") do
            expect(page).to have_content(message)
        end
    end
end