require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "Visit all available pages" do
    before do
        log_in_auto
    end

scenario "twitter charts load: accounts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("twitter")
            click_link("accounts")
        end
        select_subaccounts
        within(".main-content") do
            expect(page).to have_content("TWEETS")
            expect(page).to have_content("TWITTER FOLLOWERS")
            expect(page).to have_content("RETWEETS OF")
            expect(page).to have_content("MENTIONS")
        end
    end

    scenario "twitter charts load: tweets" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("twitter")
            click_link("tweets")
        end
        select_subaccounts
        within(".main-content") do
            expect(page).to have_content("RETWEETS BY DATE")
            expect(page).to have_content("RETWEET RATE")
            expect(page).to have_content("FAV")
        end
    end
end