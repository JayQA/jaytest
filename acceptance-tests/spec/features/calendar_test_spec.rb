require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Shoutbox
now = Time.now.to_i.to_s

feature "Calendar Test spec" do 
	before do
		log_in_auto()
	end

	scenario "Details in the Drawer (Targetting, tags, campaigns, author)" do

		shoutbox_open
		shoutbox_destination("Full Price Books")
		shoutbox_destination("Bill_Cumin")
		shoutbox_destination("Cool page for fun timez")
		shoutbox_destination("billcumin")
		shoutbox_destination("Neat Answer Inc.")
		shoutbox_message("Testing shout for verification in the drawer " + now)
		shoutbox_campaign("Automatic")
		shoutbox_tag("automatedtag")
		shoutbox_facebook_target("PHP QD Targeting")
		shoutbox_gplus_target("Extended Circles")
		shoutbox_twitter_target("United States")
		shoutbox_save
		shoutbox_close
		main_nav_calendar
		sleep(3)
		find("span", :text => "Testing shout for verification in the drawer " + now).click
		within("#right-column") do
			expect(page).to have_content("Full Price Books")
			expect(page).to have_content("Bill_Cumin")
			expect(page).to have_content("Cool page for fun timez")
			expect(page).to have_content("billcumin")
			expect(page).to have_content("Neat Answer Inc.")
			expect(page).to have_content("Automatic")
			expect(page).to have_content("automatedtag")
			expect(page).to have_content("Country: United States")
			expect(page).to have_content("Targeting 2 circles")
			if Capybara.default_driver == :selenium
				expect(page).to have_content("United States (country)")
			else
				expect(page).to have_content("United States (Country)")
			end
			expect(page).to have_content("Auto Capy")
		end
	end

	scenario "Removing the shout from the calendar" do

		main_nav_calendar
		find("span", :text => "Testing shout for verification in the drawer " + now).click
		within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
	end


end