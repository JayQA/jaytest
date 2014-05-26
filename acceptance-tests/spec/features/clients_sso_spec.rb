require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Helper

feature "Check SSO connections with Mutal Mind, Zendesk, and Wiki", :clients => true  do
    before do
        log_in_clients_standard
    end

    scenario "Log in to Mutual Mind", :broken => true do
        main_nav_listening
        expect(page).to have_content("WELCOME TO SHOUTLET ENTERPRISE LISTENING")
        expect(page).to have_content("Campaign")
        visit "clients.shoutlet.com"
    end

    scenario "Log into Zendesk" do
        main_nav_zendesk
        helper_switch_to_new_window{
            expect(page).to have_content("Submit a request")
            expect(page).to have_content("Please select the ticket type from this drop down")
        }
    end

    scenario "Log into the Wiki" do
        main_nav_wiki
        helper_switch_to_new_window{
            expect(page).to have_content("API Reference Guide")
            expect(page).to have_content("Forrester Groundswell Awards")
        }
    end

    scenario "Log into Shoutlet U" do
        main_nav_shoutletu
        helper_alert_confirm
        helper_switch_to_new_window{
            expect(page).to have_content("WELCOME TO SHOUTLET UNIVERSITY")
            expect(page).to have_content("CUSTOMER OF THE MONTH")
        }
    end


end