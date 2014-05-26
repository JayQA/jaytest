require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Shoutbox
now = Time.now.to_i.to_s

feature "High and Urgent Fix File" do

    scenario "Assigning a Task and replying in SCRM" do
    	log_in_auto()

    	tw_timeline 
    	within("div.feed-data") do
    		click_link("assign task", :match => :first)
    	end
    	fill_in "message", :with => "Please complete this task by the end of the day. Thanks." 
    	page.select "Author Guy", :from => "assign_to"
    	click_button("Assign")
    	within("#notifications") do
            page.should have_selector(".message", :text => "Task assigned.")
        end
    end

    scenario "Replying to the Tweet of the Assigned Task" do
    	log_in_author()

    	tasks
    	within (".post-container.whole.column.mar-t20") do
    		click_link("reply", :match => :first)
    	end
    	fill_in "status", :with => "What a sick post!"
    	click_button("Request Approval")
    	within("#notifications") do
            page.should have_selector(".message", :text => "Tweet approval requested")
        end
    end

    scenario "Approving the Tweet Reply" do
    	log_in_auto()

    	wf_approvals
    	within("#approvals_wrapper") do
    		fill_in "filter_box", :with => "What"
    		# Alternate way to do this for reference.
    		# find(:css, "#approvals_filter input[aria-controls='approvals']").set("What")
    	end
    	within(".dataTables_scrollBody") do
    		click_link("view", :match => :first)
    	end
    	expect(page).to have_content("STATUS DISTRIBUTION")
    	page.choose "workflow_approve"
    	click_button("save_and_publish")
    	within("#notifications") do
            page.should have_selector(".message", :text => "Shout has been approved")
            page.should have_selector(".message", :text => "Shout has been published")
        end
    end

    scenario "Custom Twitter Message Not Showing in Calendar for Regular Shouts Test" do
		log_in_auto()

    	shoutbox_open
    	shoutbox_destination("Full Price Books")
    	shoutbox_message("Slick sauce, today is " +now)
    	shoutbox_save
    	shoutbox_close
    	main_nav_calendar
        sleep(2)
    	find("span", :text=> "Slick sauce, today is ").click
    	within(".actions") do
            find(".edit.icon").click
        end
        sleep(3)
        within(".composer") do
            fill_in "s_message", with: "Slick sauce, today is " + now + " with an edit."
        end
    	shoutbox_save
    	within("#right-column") do
    		expect(page).to have_no_content("Twitter Message")
    	end
    end

    scenario "Deleting the shout without the custom Twitter Message" do
        log_in_auto()

        main_nav_calendar
        find("span", :text=> "Slick sauce, today is " + now).click
        within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
    end

    scenario "Making sure Twitter custom message shows up in the Calendar" do
    	log_in_auto()

    	shoutbox_open
    	shoutbox_destination("Full Price Books")
    	shoutbox_destination("Bill_Cumin")
    	shoutbox_message("Facebook Message " + now)
    	shoutbox_twitter_custom("Custom Twitter")
    	shoutbox_save
    	shoutbox_close
    	main_nav_calendar
        sleep(2)
    	find("span", :text=> "Facebook Message ").click
    	within("#right-column") do
    		expect(page).to have_content("Twitter Message")
    	end
    end

    scenario "Deleting the shout with the custom Twitter message" do
        log_in_auto()

        main_nav_calendar
        find("span", :text=> "Facebook Message " + now).click
        within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
    end

    scenario "Creating a shout on a Shared down account" do
        log_in_auto()

        shoutbox_open
        shoutbox_destination("Bob Loblaw's FB Page")
        shoutbox_message("Assigned down Message " + now)
        shoutbox_save
        shoutbox_close    
    end

    scenario "Viewing the shout and attempting to edit on the sub" do
        log_in_sub()

        main_nav_calendar
        sleep(3)
        find("span", :text=> "Assigned down Message " + now).click
        within("#right-column") do
            expect(page).to have_content("Bob Loblaw's FB Page")
            expect(page).to have_no_content(".edit.icon")
        end
    end

    scenario "Deleting the shout on the parent account" do
        log_in_auto()

        main_nav_calendar
        find("span", :text=> "Assigned down Message " + now).click
        within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
    end

    scenario "Editing a local role should not result in attached account duplication" do
        log_in_auto()

        wf_roles
        within("#DataTables_Table_1_wrapper") do
            find("a", :text=> "All perms local role").click
        end
        within(".main-section.top") do
            expect(page).to have_content("EDIT ROLE")
        end
        click_button("save")
        within("#DataTables_Table_1_wrapper") do
            find("a", :text=> "All perms local role").click
        end
        expect(page).to have_content("Sub account for Sub User")
        expect(page).to have_content("First Sub Account Created")
    end

end