require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav

# page.driver.enable_logging

feature "Visit all available pages" do
    before do
        log_in_auto
    end


    # scenario "goes to search page" do
    #     within("#header") do
    #         click_link("search")
    #     end
    #     within(".main-section.top") do
    #         expect(page).to have_content("SEARCH")
    #     end
    # end

    ### LEGACY SCRM ###
    ### FACEBOOK ###

    scenario "goes to legacy Facebook posts" do
        within("#side-navigation") do
            click_link("facebook")
            click_link("posts")
        end
        within(".main-section.top") do
            expect(page).to have_content("POSTS")
        end
    end

    scenario "goes to legacy Facebook comments" do
        within("#side-navigation") do
            click_link("facebook")
            click_link("comments")
        end
        within(".main-section.top") do
            expect(page).to have_content("COMMENTS")
        end
    end

    scenario "goes to legacy Facebook likes" do
        within("#side-navigation") do
            click_link("facebook")
            click_link("likes")
        end
        within(".main-section.top") do
            expect(page).to have_content("LIKES")
        end
    end

    scenario "goes to legacy Facebook active fans" do
        within("#side-navigation") do
            click_link("facebook")
            click_link("active fans")
        end
        within(".main-section.top") do
            expect(page).to have_content("ACTIVE FANS")
        end
    end

    scenario "goes to legacy Facebook manage albums" do
        within("#side-navigation") do
            click_link("facebook")
            click_link("manage albums")
        end
        within(".main-section.top") do
            expect(page).to have_content("MANAGE ALBUMS")
        end
    end

    scenario "goes to legacy Facebook upload to album" do
        within("#side-navigation") do
            click_link("facebook")
            click_link("upload to album")
        end
        within(".main-section.top") do
            expect(page).to have_content("UPLOAD TO ALBUM")
        end
    end

    ### TWITTER ###

    scenario "goes to legacy Twitter timeline" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("timeline")
        end
        within(".main-section.top") do
            expect(page).to have_content("TWITTER TIMELINE")
        end
    end

    scenario "goes to legacy Twitter mentions" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("mentions")
        end
        within(".main-section.top") do
            expect(page).to have_content("TWITTER MENTIONS")
        end
    end

    scenario "goes to legacy Twitter retweets" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("retweets")
        end
        expect(".title").to have_content("TWITTER RETWEETS")
    end

    scenario "goes to legacy Twitter direct messages" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("direct messages")
        end
        within(".main-section.top") do
            expect(page).to have_content("DIRECT MESSAGES")
        end
    end

    scenario "goes to legacy Twitter followers" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("followers")
        end
        within(".main-section.top") do
            expect(page).to have_content("TWITTER FOLLOWERS")
        end
    end

    scenario "goes to legacy Twitter following" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("following")
        end
        within(".main-section.top") do
            expect(page).to have_content("TWITTER FOLLOWING")
        end
    end

    scenario "goes to legacy Twitter lists" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("lists")
        end
        within(".main-section.top") do
            expect(page).to have_content("TWITTER LISTS")
        end
    end

    scenario "goes to legacy Twitter my lists" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("my lists")
        end
        within(".main-section.top") do
            expect(page).to have_content("MY TWITTER LISTS")
        end
    end

    scenario "goes to legacy Twitter search" do
        within("#side-navigation") do
            click_link("twitter")
            click_link("search terms")
        end
        expect(page).to have_css(".twitter.feed-container")
        within(".main-section.top") do
            expect(page).to have_content("TWITTER SEARCH TERMS")
        end
    end

    ### YOUTUBE ###

    scenario "goes to Youtube comments" do
        within("#side-navigation") do
            click_link("youtube")
            click_link("comments")
        end
        within(".main-section.top") do
            expect(page).to have_content("YOUTUBE COMMENTS")
        end
    end

    scenario "goes to Youtube shared videos" do
        within("#side-navigation") do
            click_link("youtube")
            click_link("shared with me")
        end
        within(".main-section.top") do
            expect(page).to have_content("VIDEOS SHARED WITH ME")
        end
    end

    scenario "goes to Youtube my uploads" do
        within("#side-navigation") do
            click_link("youtube")
            click_link("my uploads")
        end
        within(".main-section.top") do
            expect(page).to have_content("YOUTUBE VIDEOS")
        end
    end

    scenario "goes to Youtube search" do
        within("#side-navigation") do
            click_link("youtube")
            click_link("search")
        end
        within(".main-section.top") do
            expect(page).to have_content("YOUTUBE SEARCH")
        end
    end

    ### FOURSQUARE ###

    scenario "goes to Foursquare activity" do
        within("#side-navigation") do
            click_link("foursquare")
            click_link("activity")
        end
        within(".main-section.top") do
            expect(page).to have_content("FOURSQUARE")
        end
    end

    scenario "goes to Foursquare venues" do
        within("#side-navigation") do
            click_link("foursquare")
            click_link("venues")
        end
        within(".main-section.top") do
            expect(page).to have_content("FOURSQUARE VENUES")
        end
    end

    scenario "goes to Foursquare specials" do
        within("#side-navigation") do
            click_link("foursquare")
            click_link("specials")
        end
        within(".main-section.top") do
            expect(page).to have_content("FOURSQUARE SPECIALS")
        end
    end

    scenario "goes to Foursquare campaigns" do
        within("#side-navigation") do
            click_link("foursquare")
            within(".foursquare") do
                click_link("campaigns")
            end
        end
        within(".main-section.top") do
            expect(page).to have_content("FOURSQUARE CAMPAIGNS")
        end
    end

    scenario "goes to Foursquare groups" do
        within("#side-navigation") do
            click_link("foursquare")
            click_link("groups")
        end
        within(".main-section.top") do
            expect(page).to have_content("FOURSQUARE GROUPS")
        end
    end

    ### LINKEDIN ###

    scenario "goes to Linkedin scrm" do
        within("#side-navigation") do
            click_link("linkedin")
        end
        within(".main-section") do
            expect(page).to have_content("LINKEDIN COMPANIES")
        end
    end

    ### ADMINISTRATION ###

    scenario "goes to accounts" do
        click_link("administration")
        click_link("accounts")
        within(".main-section.top") do
            expect(page).to have_content("ALL ACCOUNTS")
        end
    end

    scenario "goes to roles" do
        click_link("administration")
        click_link("roles")
        expect(page).to have_content("GLOBAL ROLES")
        expect(page).to have_content("LOCAL ROLES")
    end

    scenario "goes to approvals" do
        click_link("administration")
        click_link("approvals")
        within(".main-section.top") do
            expect(page).to have_content("APPROVALS")
        end
    end

    ### SIDE NAV BAR ###

    scenario "goes to managed urls" do
        click_link("manage urls")
        within(".main-section.top") do
            expect(page).to have_content("MANAGE URLS")
        end
    end

    scenario "goes to tags and campaigns" do
        click_link("campaigns & tags")
        within("#campaignlist_wrapper") do
            expect(page).to have_content("NAME")
            expect(page).to have_content("SHOUTS")
            expect(page).to have_content("CREATED")
        end
        within("#tagcloud_wrapper") do
            expect(page).to have_content("test")
        end
    end

    scenario "goes to tasks" do
        click_link("tasks")
        within(".main-section.top") do
            expect(page).to have_content("ALL YOUR TASKS")
        end
    end

    scenario "goes to RSS feeds" do
        click_link("feeds")
        click_link("RSS feeds")
        within(".main-section.top") do
            expect(page).to have_content("RSS LIBRARY")
        end
    end

    ### PROFILES ###

    scenario "goes to export profiles" do
        click_link("shoutlet profiles")
        click_link("export profiles")
        within(".main-section.top") do
            expect(page).to have_content("SHOUTLET PROFILES > EXPORT")
        end
    end

    scenario "goes to import profiles" do
        click_link("shoutlet profiles")
        click_link("import profiles")
        within(".main-section.top") do
            expect(page).to have_content("SHOUTLET PROFILES > IMPORT")
        end
    end

    scenario "goes to social segments" do
        click_link("shoutlet profiles")
        click_link("list segments")
        within(".main-section.top") do
            expect(page).to have_content("SHOUTLET PROFILES > LIST SOCIAL SEGMENTS")
        end
    end

    scenario "goes to shoutlet profiles" do
        click_link("shoutlet profiles")
        click_link("list profiles")
        within(".main-section.top") do
            expect(page).to have_content("SHOUTLET PROFILES")
        end
    end

    ### PUBLICATIONS ###

    scenario "goes to contests" do
        contests()
    end

    scenario "goes to everywhere pages" do
        click_link("publications")
        click_link("everywhere pages")
        within(".main-section.top") do
            expect(page).to have_content("EVERYWHERE PAGES")
        end
    end

    scenario "goes to multi app distro" do
        click_link("publications")
        click_link("multi app")
        within(".main-section.top") do
            expect(page).to have_content("MULTI APP DISTRIBUTIONS")
        end
    end

    scenario "goes to facebook tabs" do
        click_link("publications")
        click_link("facebook apps (tabs)")
        within(".main-section.top") do
            expect(page).to have_content("FACEBOOK APPS (TABS)")
        end
    end

    ### TOP NAV BAR ###

    scenario "goes to settings", :broken => true do
        find(:css, '.client-name').click
        click_on "Settings"
        expect(page).to have_content("OVERVIEW FOR AUTOMATED PARENT ACCOUNT")
    end

    scenario "goes to library" do
        click_link("library")
        expect(page).to have_content("AUTOMATED PARENT ACCOUNT LIBRARY")
    end

    scenario "goes to new calendar" do
        click_link("calendar")
        within(".menu") do
            expect(page).to have_content("Today")
            expect(page).to have_content("Month")
            expect(page).to have_content("Week")
            expect(page).to have_content("Day")
            expect(page).to have_content("Agenda")
        end
    end

    scenario "goes to switchboard" do
        click_link("switchboard")
        expect(page).to have_content("WELCOME TO SWITCHBOARD")
    end

    scenario "goes to canvas" do
        click_link("canvas")
        expect(page).to have_content("WELCOME TO SOCIAL CANVAS")
    end

    scenario "goes to scrm v2" do
        click_link("social crm")
        expect(page).to have_css(".scrm.active")
        expect(page).to have_content("Automated Parent Account Board")
    end

end
