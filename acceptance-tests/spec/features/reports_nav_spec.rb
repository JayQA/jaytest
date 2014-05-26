require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "Visit all report pages" do
    before do
        log_in_auto
    end

    ### ENTERPRISE ACCOUNT REPORTS ###

    scenario "goes to enterprise - pages" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        click_link("pages")
        within(".main-section") do
            expect(page).to have_content("PAGES")
        end
    end

    scenario "goes to enterprise - pages export" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        click_link("pages export")
        within(".main-section") do
            expect(page).to have_content("PAGES EXPORT")
        end
    end

    scenario "goes to enterprise - posts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        click_link("posts")
        within(".main-section") do
            expect(page).to have_content("POSTS")
        end
    end

    scenario "goes to enterprise - leaderboards" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        click_link("leaderboards")
        within(".main-section") do
            expect(page).to have_content("USERS")
        end
    end

    scenario "goes to enterprise - library" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("library")
        end
        within(".main-section") do
            expect(page).to have_content("OVERVIEW")
        end
    end

    scenario "goes to enterprise - individual" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        click_link("individual")
        within(".main-section") do
            expect(page).to have_content("INDIVIDUAL REPORTS")
        end
    end

    scenario "goes to enterprise - compare" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        click_link("compare")
        within(".main-section") do
            expect(page).to have_content("COMPARE")
        end
    end

    ### LEGACY FACEBOOK REPORTS ###

    scenario "goes to facebook - overview" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]/a').click
        within("#side-navigation") do
            click_link("overview")
        end
        select_subaccounts
        within(first(".main-section")) do
            expect(page).to have_content("FACEBOOK OVERVIEW")
        end
    end

    scenario "goes to facebook - likes" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within("#side-navigation") do
            click_link("likes")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("PEOPLE WHO LIKE YOUR PAGE")
        end
    end

    scenario "goes to facebook - reach" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within("#side-navigation") do
            click_link("reach")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("FACEBOOK REACH")
        end
    end

    scenario "goes to facebook - talking about this" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within("#side-navigation") do
            click_link("talking about this")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("FACEBOOK PEOPLE TALKING ABOUT THIS")
        end
    end

    scenario "goes to facebook - posts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within(:xpath, '//*[@id="side-navigation"]/li[5]') do
            click_link("posts")
        end
        select_subaccounts
        within("#aggregatedTab") do
            expect(page).to have_content("AGGREGATED POST DATA")
        end
    end

    scenario "goes to facebook - shops" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within("#side-navigation") do
            click_link("shops")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("FACEBOOK SHOP N SHARE")
        end
    end

    scenario "goes to facebook - targeting groups" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        find(:xpath, '//*[@id="side-navigation"]/li[5]').click_link("facebook")
        within("#side-navigation") do
            click_link("targeting groups")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("FACEBOOK TARGETING GROUPS")
        end
    end

    ### TWITTER REPORTS ###

    scenario "goes to twitter - accounts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("twitter")
            click_link("accounts")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("TWITTER")
        end
    end

    scenario "goes to twitter - tweets" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("twitter")
            click_link("tweets")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("TWEETS")
        end
    end

    ### YOUTUBE ###

    scenario "goes to youtube" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("youtube")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("YOUTUBE")
        end
    end

    ### LINKEDIN ###

    scenario "goes to linkedin" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("linkedin")
        end
        select_subaccounts
        within(:xpath, '//*[@id="container"]/div[2]/div[1]') do
            expect(page).to have_content("LINKEDIN")
        end
    end

    ### FOURSQUARE ###

    scenario "goes to foursquare" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("foursquare")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("FOURSQUARE")
        end
    end

    ### CANVAS ###

    scenario "goes to canvas" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("canvas")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("CANVAS")
        end
    end

    ### SHOUTLET PROFILES ###

    scenario "goes to shoutlet profiles" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("shoutlet profiles")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("SHOUTLET PROFILES")
        end
    end

    ### CONTESTS ###

    scenario "goes to contests" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("contests")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("CONTEST RESULTS")
        end
    end

    ### POLLS ###

    scenario "goes to polls" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("polls")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("POLL RESULTS")
        end
    end

    ### CLICK TRACKING ###

    scenario "goes to click tracking - published URLs" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("click tracking")
            click_link("published URLs")
        end
        select_subaccounts
        within("#tabs") do
            expect(page).to have_content("AGGREGATED LINKS")
            expect(page).to have_content("INDIVIDUAL LINKS")
        end
    end

    scenario "goes to click tracking - managed URLs" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("click tracking")
            click_link("managed URLs")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("LINK TRACKING")
        end
    end

    scenario "goes to click tracking - kenshoo revenue" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("click tracking")
            click_link("kenshoo revenue")
        end
        # select_subaccounts
        within(".main-section") do
            expect(page).to have_content("KENSHOO REVENUE")
        end
    end

    scenario "goes to click tracking - export report" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("click tracking")
            click_link("export report")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("LINK TRACKING")
        end
    end

    ### Custom Report Builder ###

    scenario "goes to custom reports" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("custom")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("CUSTOM REPORT BUILDER")
        end
    end

    ### MEDIA ###

    scenario "goes to media - audio/video" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("media")
            click_link("audio/video")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("AUDIO/VIDEO")
        end
    end

    scenario "goes to media - podcasts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("media")
            click_link("podcasts")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("PODCASTS")
        end
    end

    scenario "goes to media - messaging" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("media")
            click_link("messaging")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("MESSAGING")
        end
    end

    scenario "goes to media - contacts" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("media")
            click_link("contacts")
        end
        select_subaccounts
        within(".reportModBody") do
            expect(page).to have_content("CONTACT GROWTH")
        end
    end

    scenario "goes to media - rss" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("media")
            click_link("rss")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("RSS")
        end
    end

    scenario "goes to media - web apps" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("media")
            click_link("web apps")
        end
        select_subaccounts
        within(".main-section") do
            expect(page).to have_content("WEB APPS")
        end
    end

    ### SAVED ###

    scenario "goes to saved" do
        click_link("reports")
        expect(page).to have_content("ENTERPRISE ACCOUNT FACEBOOK REPORTS")
        within("#side-navigation") do
            click_link("saved")
        end
        # select_subaccounts
        within(".main-section") do
            expect(page).to have_content("SAVED REPORTS")
        end
    end

end
