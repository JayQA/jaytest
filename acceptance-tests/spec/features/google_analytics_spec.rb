require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Google Analytics Connections", :broken => true do
    before do
        log_in_auto()
        within("#profile-information") do
            find(".client-name").click
        end
        within("#profile-menu") do
            click_link "Settings"
        end
        within(:xpath, '//*[@id="container"]/div[2]/div[1]') do
            expect(page).to have_content("OVERVIEW FOR AUTOMATED PARENT ACCOUNT")
        end
    end

    scenario "Search for a sub account" do
        # within("#account_search_form") do
        #     fill_in "c_name", with: "first"
        #     click_button "go"
        # end
        # within(".default.checklist") do
        #     expect(page).to have_content("First")
        #     expect(page).to have_no_content("Second")
        # end
    end
end
