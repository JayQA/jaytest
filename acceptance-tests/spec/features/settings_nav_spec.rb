require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include SettingsNav

feature "Visit all available pages", :broken => true do
    before do
        log_in_auto
    end

    scenario "goes to overview" do
        go_to_settings
    end

    scenario "goes to general" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("general")
    	end
    	expect(page).to have_content("CHANGE PASSWORD")
    end

    scenario "goes to facebook - login apps" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("login apps")
    	end
    	expect(page).to have_content("FACEBOOK LOGIN APPS")
    end

    scenario "goes to facebook - apps (tabs)" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("apps (tabs)")
    	end
    	expect(page).to have_content("FACEBOOK APPS (TABS)")
    end

    scenario "goes to facebook - white label app" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("white label app")
    	end
    	expect(page).to have_content("SET UP YOUR WHITE LABEL APP")
    end

    scenario "goes to facebook - add account" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("add account")
    	end
    	expect(page).to have_content("ADD A FACEBOOK ACCOUNT")
    end

    scenario "goes to facebook - manage accounts" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("manage accounts")
    	end
    	expect(page).to have_content("MANAGE FACEBOOK ACCOUNTS AND PAGES")
    end

    scenario "goes to facebook - fan tags" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("fan tags")
    	end
    	expect(page).to have_content("FAN TAGGING")
    end

    scenario "goes to facebook - post tags" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("facebook")
    		click_link("post tags")
    	end
    	expect(page).to have_content("POST, COMMENT, & LIKE TAGGING")
    end

    scenario "goes to twitter - add account" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("twitter")
    		click_link("add account")
    	end
    	expect(page).to have_content("ADD A TWITTER ACCOUNT")
    end

    scenario "goes to twitter - manage accounts" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("twitter")
    		click_link("manage accounts")
    	end
    	expect(page).to have_content("MANAGE TWITTER ACCOUNTS")
    end

    scenario "goes to linkedin - add account" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("linkedin")
    		click_link("add account")
    	end
    	expect(page).to have_content("ADD A LINKEDIN ACCOUNT")
    end

    scenario "goes to linkedin - manage accounts" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("linkedin")
    		click_link("manage accounts")
    	end
    	expect(page).to have_content("MANAGE LINKEDIN ACCOUNTS")
    end

    scenario "goes to google+ - add account" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("google+")
    		click_link("add account")
    	end
    	expect(page).to have_content("ADD A GOOGLE+ ACCOUNT")
    end

    scenario "goes to google+ - manage accounts" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("google+")
    		click_link("manage accounts")
    	end
    	expect(page).to have_content("MANAGE GOOGLE+ ACCOUNTS")
    end

    scenario "goes to youtube - add account" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("youtube")
    		click_link("add account")
    	end
    	expect(page).to have_content("ADD A YOUTUBE ACCOUNT")
    end

    scenario "goes to youtube - manage accounts" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("youtube")
    		click_link("manage accounts")
    	end
    	expect(page).to have_content("MANAGE YOUTUBE ACCOUNTS")
    end

    scenario "goes to foursquare - add account" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("foursquare")
    		click_link("add account")
    	end
    	expect(page).to have_content("ADD A FOURSQUARE ACCOUNT")
    end

    scenario "goes to foursquare - manage accounts" do
    	go_to_settings
    	within("#side-navigation") do
    		click_link("foursquare")
    		click_link("manage accounts")
    	end
    	expect(page).to have_content("MANAGE FOURSQUARE ACCOUNTS")
    end

end
