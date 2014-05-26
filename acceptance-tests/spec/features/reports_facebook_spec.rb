require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "Visit all available pages" do
    before do
        log_in_auto
    end
scenario "overview chart loads" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within("#side-navigation") do
            click_link("overview")
        end
        if page.has_content?("SELECT FILTERS")
            find(:xpath, '//*[@id="subaccount-form"]/div[1]/table/tbody/tr[1]/td[1]/input').set(true)
            find("#submitMap").click
            expect(page).to have_css('div#A1')
        end
    end
scenario "goes to facebook - posts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within(:xpath, '//*[@id="side-navigation"]/li[5]') do
            click_link("posts")
        end
        if page.has_content?("SELECT FILTERS")
            find(:xpath, '//*[@id="subaccount-form"]/div[1]/table/tbody/tr[1]/td[1]/input').set(true)
            find("#submitMap").click
            sleep 5
            expect(page).to have_content("organic")
        end
    end
end