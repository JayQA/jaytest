require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Shoutbox

now = Time.now.to_i.to_s

feature "Workflow Approvals Section" do

     scenario "Create a shout and submit to workflow as an Publisher" do

    	log_in_auto

    	### Open the Shoutbox ###
    	shoutbox_open

       ### Add networks to the shout ###
        shoutbox_destination("Full Price Books")

        ### Add message content ###
        shoutbox_message("This is a new publisher message for " + now + ".")

        ### Submit Post ###
        within("#s2id_autogen10") do
        	find(".select2-arrow").click
        end
        within(".select2-drop") do
        	find(".select2-result-label", :text => "Default Workflow").click
        end
        click_button("submit")
        sleep(3)
    end

   scenario "Approve the shout as the Publisher when the post is coming from a Publisher" do

    	log_in_auto

    	### Go to the calendar ###
        main_nav_calendar
        within(".menu") do
            find(".week").click
        end

        ### Click the shout we created above and load it in the drawer ###
        find("span", :text=> "publisher message for " + now).click
        within("#right-column") do
        	expect(page).to have_content("SHOUT HISTORY")
        	expect(page).to have_content("Approve")
        	expect(page).to have_content("Deny")
        end

        ###Approve the shout ###
        within("#right-column") do
            expect(page).to have_content("Pending Approval")
        	find("a", :text => "Approve").click
        end
        within(".workflow-composer") do
        	fill_in "notes", with: "Approving this Post"
        end
        within(".footer") do
        	find("button", :text => "submit").click
        end
        within("#right-column") do
        	expect(page).to have_content("SHOUT HISTORY")
            expect(page).to have_content("Approved by: Auto Capy (Step 1 of 1)")
            expect(page).to have_content("Submitted to: Default Workflow")
        end
    end
    
    scenario "Delete the shout now that it has been approved second time" do
        log_in_auto()

        main_nav_calendar
        find("span", :text=> "publisher message for " + now).click
        within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
    end

    scenario "Create a shout as an Author and submit to workflow with the intention of it getting denied." do
        log_in_author()

        within("#header") do
            find("#global-post-button").click
        end
        shoutbox_destination("Full Price Books")
        shoutbox_message("This is a slick post for submission " + now)
        click_button("submit")
        sleep(3)
    end

    scenario "Deny the shout as the Publisher" do
        log_in_auto()

        main_nav_calendar
        find("span", :text=> "This is a slick post for submission " + now).click
         within("#right-column") do
            find("a", :text => "Deny").click
        end
        within(".workflow-composer") do
            fill_in "notes", with: "Denying this Post"
        end
        within(".footer") do
            find("button", :text => "submit").click
        end
    end

    scenario "Resubmit as the author" do
        log_in_author()

        main_nav_calendar
        find("span", :text=> "This is a slick post for submission " + now).click
        within(".actions") do
            find(".edit.icon").click
        end
        sleep(2)
        shoutbox_message("This is a resubmission " + now)
        click_button("submit")
        sleep(2)
    end

    scenario "Approving the resubmission as a Publisher" do
        log_in_auto()

        main_nav_calendar
        find("span", :text=> "This is a slick post for submission " + now).click
        within("#right-column") do
            expect(page).to have_content("Pending Approval")
            find("a", :text => "Approve").click
        end
        within(".workflow-composer") do
            fill_in "notes", with: "Approving this Post"
        end
        within(".footer") do
            find("button", :text => "submit").click
        end
        within("#right-column") do
            expect(page).to have_content("SHOUT HISTORY")
            expect(page).to have_content("Approved by: Auto Capy (Step 1 of 1)")
            expect(page).to have_content("Submitted to: Default Workflow")
        end
    end

    scenario "Cleanup: deleting the shout from the calendar" do
          log_in_auto()

        main_nav_calendar
        find("span", :text=> "This is a slick post for submission " + now).click
        within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
        expect(page).to have_no_content("This is a slick post for submission " + now)
    end

end
