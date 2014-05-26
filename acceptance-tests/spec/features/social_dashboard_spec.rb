require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "Visit all available pages" do
    before do
        log_in_auto
    end

scenario "facebook badge loads" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[1]').click_link("dashboard")
        if page.has_content?("SELECT FILTERS")
            find(:xpath, '//*[@id="subaccount-form"]/div[1]/table/tbody/tr[1]/td[1]/input').set(true)
            find("#submitMap").click
            expect(page).to have_content("Fan Growth")
    end
end

scenario "twitter badge loads" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[1]').click_link("dashboard")
        if page.has_content?("SELECT FILTERS")
            find(:xpath, '//*[@id="subaccount-form"]/div[1]/table/tbody/tr[1]/td[1]/input').set(true)
            find("#submitMap").click
            within(".badge.badge-percentage.column.one-fourth.twitter") do
                expect(page).to have_content("Follower Growth")
            end
        end 
    end       

scenario "linkedin badge loads" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[1]').click_link("dashboard")
        if page.has_content?("SELECT FILTERS")
            find(:xpath, '//*[@id="subaccount-form"]/div[1]/table/tbody/tr[1]/td[1]/input').set(true)
            find("#submitMap").click
            within(".badge.badge-percentage.column.one-fourth.linkedin") do
                expect(page).to have_content("Follower Growth")
            end
        end
    end  

scenario "youtube badge loads" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[1]').click_link("dashboard")
        if page.has_content?("SELECT FILTERS")
            find(:xpath, '//*[@id="subaccount-form"]/div[1]/table/tbody/tr[1]/td[1]/input').set(true)
            find("#submitMap").click
            expect(page).to have_content("View Growth")
        end
    end
end