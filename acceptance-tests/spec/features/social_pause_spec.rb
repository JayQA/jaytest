### Social Pause Spec ###

require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include SettingsNav
include Main_nav

feature "Interact with Social Pause" do
    before do
        log_in_auto("gabel")
    end

    scenario "Enable Social Pause" do
        go_to_settings
        within("#side-navigation") do
            click_link "social pause"
        end
        within(".main-section") do
            expect(page).to have_content("SOCIAL PAUSE")
        end
        choose("enable_button")
        find("#social_pause_submit").click
        within("#confirm-modal") do
            expect(page).to have_content("Enable Social Pause?")
            find("a", :text => "Enable Social Pause").click
        end
        within("#admin-header") do
            expect(page).to have_content("SOCIAL PAUSE ENABLED")
        end
        within(".content-box") do
            expect(page).to have_content("SOCIAL PAUSE IS ENABLED")
        end
    end

    scenario "If Scocial Pause is enabled for a parent account, it should be enabled for all it's sub accounts" do
        find(:css, '.client-name').click
        within(".client-list") do
            find("a", :text => "First Sub Account Created").click
        end
        within(".client-name") do
            expect(page).to have_content("First Sub Account Created")
        end
        within(".error.announcement") do
            expect(page).to have_content("Social Activity Paused")
        end
    end

    scenario "A Shout should not publish when Social Pause is enabled" do
        within("#header") do
            find("#global-post-button").click
        end
        within(".shout-modal-container") do
            expect(page).to have_content("save")
            expect(page).to have_content("Social Activity is currently paused.")
            within(".footer") do
                expect(page).to have_no_content("post")
            end
        end
    end

    scenario "SCRM interactions should be disabled if Social Pause is enabled" do
        main_nav_scrm

        #Open a Facebook post item and verify you can't comment or reply, but can like
        find('#stack_' + $my_options['facebook_reply']['stackid_1'] + ' > div.items.hide > div:nth-child(1)').click
        within(".vantage-modal-content") do
            expect(page).to have_no_css("#facebook-comment")
            expect(page).to have_no_css(".fb-reply")
            within(".vantage-modal-item-wrap") do
                expect(page).to have_css(".fb-like-toggle")
            end
        end

        #Open a tweet item and verify you can't reply or retweet, but can favorite
        find("#stack_" + $my_options['twitter_reply']['stack_id'] + " > div.items > div:nth-child(1)").click
        within(".vantage-modal-content") do
            expect(page).to have_no_css("#reply-tweet")
            expect(page).to have_no_css("#retweet-tweet")
            within(".vantage-model-inner-wrap") do
                expect(page).to have_css(".tweet-favorite-toggle")
            end
        end

        #Open a Facebook PM item and verify there is no option to reply
        find("#stack_7106 > div.items > div:nth-child(1) > p").click
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".modal-actions.simple-reply")
        end

        #Open a Twitter DM item and verify there is no option to reply
        find("#stack_7107 > div.items > div:nth-child(1)").click
        within(".vantage-modal-content") do
            expect(page).to have_no_css(".modal-actions.simple-reply")
        end
    end

    scenario "Disable Social Pause" do
        within("#admin-header") do
            expect(page).to have_content("SOCIAL PAUSE ENABLED")
        end
        go_to_settings
        within("#side-navigation") do
            click_link "social pause"
        end
        within(".main-section") do
            expect(page).to have_content("SOCIAL PAUSE")
        end
        choose("disable_button")
        find("#social_pause_submit").click
        within(".content-box") do
            expect(page).to have_content("SOCIAL PAUSE IS DISABLED")
        end
    end

    scenario "After Social Pause is enabled, shouts should be able to be published" do
        within("#header") do
            find("#global-post-button").click
        end
        within(".shout-modal-container") do
            expect(page).to have_content("save post")
            expect(page).to have_no_css(".social-pause-warning")
        end
    end

end