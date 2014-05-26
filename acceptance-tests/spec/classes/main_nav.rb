module Main_nav

    def main_nav_home
        within("#header") do
            find("#homepage-button").click
        end
    end

    def main_nav_scrm
        click_link("social crm")
        expect(page).to have_content("scrm")
    end

    def main_nav_canvas
        click_link("canvas")

    end

    def main_nav_swithboard
        click_link("switchboard")

    end

    def main_nav_reports
        click_link("reports")

    end

    def main_nav_calendar
        click_link("calendar")
        within("#calendar-header") do
            expect(page).to have_content("calendar")
            expect(page).to have_content("Today")
            expect(page).to have_content("Month")
            sleep(2)
        end
    end

    def main_nav_library
        click_link("library")

    end

    def main_nav_listening
        find("a", :text => "listening").click

    end

    def main_nav_shoutletu
        find("#help-icon").click
        within("#help-menu") do
            click_link("shoutlet u")
        end
    end

    def main_nav_tutorials
        find("#help-icon").click
        within("#help-menu") do
            click_link("tutorials")
        end
    end

    def main_nav_wiki
        find("#help-icon").click
        within("#help-menu") do
            click_link("knowledge base")
        end
    end

    def main_nav_zendesk
        find("#help-icon").click
        within("#help-menu") do
            click_link("submit a request")
        end
    end

    # search and help


    def main_nav_search
        first('#searchbox > a').click
    end


    # side nav

    # internal functions

    def title_check(search)
        within(".main-section.top") do
            expect(".title").to have_content(search)
        end
    end

    def facebook_main
        within("#side-navigation") do
            click_link("facebook")
        end
    end

    def twitter_main
        within("#side-navigation") do
            click_link("twitter")
        end
    end

    def youtube_main
        within("#side-navigation") do
            click_link("youtube")
        end
    end

    def foursquare_main
        within("#side-navigation") do
            click_link("foursquare")
        end
    end

    def workflow_main
        within("#side-navigation") do
            click_link("administration")
        end
    end

    def publications_main
        within("#side-navigation") do
            click_link("publications")
        end

    end

    def profiles_main
        within("#side-navigation") do
            click_link("shoutlet profiles")
        end
    end

    def feeds_main
        within("#side-navigation") do
            click_link("feeds")
        end
    end

    ## functions to be used ##

    def dashboard
        click_link("dashboard")
    end

    ## WORKFLOW

    def wf_approvals
        workflow_main
        click_link("approvals")
        title_check("APPROVALS")
    end

    def wf_roles
        workflow_main
        click_link("roles")
        within(".main-section.top", :match=> :first) do
            expect(page).to have_content("ROLES")
        end
    end

    def wf_accounts
        workflow_main
        click_link("accounts")
        title_check("ACCOUNTS")
    end

    def wf_users
        workflow_main
        click_link("users")
        title_check("USERS")
    end

    def wf_mobile_access
        workflow_main
        click_link("mobile access")
        title_check("MOBILE ACCESS")
    end

    ## FACEBOOK ##

    def fb_post
        facebook_main
        click_link("posts")
        title_check("POSTS")
    end

    def fb_comments
        facebook_main
        click_link("comments")
        title_check("COMMENTS")
    end

    def fb_likes
        facebook_main
        click_link("likes")
        title_check("LIKES")
    end

    def fb_events
        facebook_main
        within(".facebook") do
            click_link("events")
        end
        title_check("EVENTS")
    end

    def fb_active_fans
        facebook_main
        click_link("active fans")
        title_check("ACTIVE FANS")
    end

    def fb_manage_albums
        facebook_main
        click_link("manage albums")
        title_check("MANAGE ALBUMS")
    end

    def fb_upload_to_album
        facebook_main
        click_link("upload to album")
        title_check("UPLOAD TO ALBUM")
    end

    ## TWITTER ##

    def tw_timeline
        twitter_main
        click_link("timeline")
        title_check("TIMELINE")
    end

    def tw_mentions
        twitter_main
        click_link("mentions")
        title_check("MENTIONS")
    end

    def tw_retweets
        twitter_main
        click_link("retweets")
        title_check("RETWEETS")
    end

    def tw_direct_messages
        twitter_main
        click_link("direct messages")
        title_check("DIRECT MESSAGES")
    end

    def tw_followers
        twitter_main
        click_link("followers")
        title_check("FOLLOWERS")
    end

    def tw_following
        twitter_main
        click_link("following")
        title_check("FOLLOWING")
    end

    def tw_lists
        twitter_main
        click_link("lists")
        title_check("LISTS")
    end

    def tw_my_lists
        twitter_main
        click_link("my lists")
        title_check("MY LISTS")
    end

    def tw_search_terms
        twitter_main
        click_link("search terms")
        title_check("SEARCH")
    end

    ## YOUTUBE ##

    def yt_comments
        youtube_main
        within(".youtube") do
            click_link("comments")
        end
        title_check("YOUTUBE COMMENTS")
    end

    def yt_shared
        youtube_main
        click_link("shared with me")
        title_check("VIDEOS SHARED WITH ME")
    end

    def yt_uploads
        youtube_main
        click_link("my uploads")
        title_check("YOUTUBE VIDEOS")
    end

    def yt_search
        youtube_main
        within(".youtube") do
            click_link("search")
        end
        title_check("YOUTUBE SEARCH")
    end


    ## FOURSQUARE ##

    def fs_activity
        foursquare_main
        click_link("activity")
        title_check("FOURSQUARE")
    end

    def fs_venues
        foursquare_main
        click_link("venues")
        title_check("FOURSQUARE VENUES")
    end

    def fs_specials
        foursquare_main
        click_link("specials")
        title_check("FOURSQUARE SPECIALS")
    end

    def fs_campaigns
        foursquare_main
        click_link("campaigns")
        title_check("FOURSQUARE CAMPAIGNS")
    end

    def fs_groups
        foursquare_main
        click_link("groups")
        title_check("FOURSQUARE GROUPS")
    end


    ## LINKEDIN ##

    def linkedin
        within("#side-navigation") do
            click_link("linkedin")
        end
        title_check("LINKEDIN COMPANIES")
    end

    ## publications ##

    def pub_apps
        publications_main
        click_link("facebook apps (tabs)")
        title_check("FACEBOOK APPS (TABS)")
    end

    def pub_multi
        publications_main
        click_link("multi app")
        title_check("MULTI APP DISTRIBUTIONS")
    end

    def pub_everywhere_pages
        publications_main
        click_link("everywhere pages")
        title_check("EVERYWHERE PAGES")
    end

    def pub_web_apps
        publications_main
        click_link("web apps")
        title_check("WEB APPS")
    end

    def pub_shops
        publications_main
        click_link("shops")
        title_check("SHOPS")
    end

    def pub_email
        publications_main
        within(".publications") do
            click_link("email")
        end
        title_check("EMAIL")
    end

    def pub_events
        publications_main
        within(".publications") do
            click_link("events")
        end
        title_check("EVENTS")

    end

    ## PROFILES ##

    def profiles_list
        profiles_main
        click_link("list profiles")
        title_check("SHOUTLET PROFILES")
    end

    def list_segments
        profiles_main
        click_link("list segments")
        title_check("LIST SOCIAL SEGMENTS")
    end

    def merge_profiles
        profiles_main
        click_link("merge profiles")
        title_check("VIEW MERGE AUDIT")
    end

    def import_profiles
        profiles_main
        click_link("import profiles")
        title_check("Import")
    end

    def export_profiles
        profiles_main
        click_link("export profiles")
        title_check("EXPORT")

    end

    ## feeds ##

    def feeds_rss
        feeds_main
        click_link("RSS feeds")
        title_check("RSS LIBRARY")
    end

    def feeds_podcast
        feeds_main
        click_link("podcasts")
        title_check("PODCAST LIBRARY")
    end


    ## OTHER ##



    def tasks
        within("#side-navigation") do
            click_link("tasks")
        end
        title_check("ALL YOUR TASKS")
    end

    def contests
        within("#side-navigation") do
            click_link("contests")
        end
        within("#contest-list-header") do
            expect(page).to have_content"Contests"
        end
    end

    def tags
        within("#side-navigation") do
            click_link("campaigns & tags")
        end
        title_check("CAMPAIGNS")
    end

    def urls
        within("#side-navigation") do
            click_link("manage urls")
        end
        title_check("MANAGE URLS")
    end

end
