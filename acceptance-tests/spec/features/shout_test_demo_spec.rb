require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Create, save, edit, and delete a shout" do
    before do
        log_in_auto
    end

    ### Createing Shout ###

    scenario "Create and save the shout" do

        ### Open the shoutbox ###
        within("#header") do
            find("#global-post-button").click
        end
        within(".shout-modal-container") do
            expect(page).to have_content("save post")
        end

        ### Add networks to the shout ###
        find("#s2id_autogen3").click
        within(".destination-dropdown") do
            expect(page).to have_content("facebook")
            expect(page).to have_content("twitter")
            expect(page).to have_content("youtube")
            expect(page).to have_content("quick distro")
            find("span", :text => $my_options['shout_test_demo_spec']['distro_page_1']).click
        end

        find("#s2id_autogen3").click
        within(".destination-dropdown") do
            expect(page).to have_content("facebook")
            expect(page).to have_content("twitter")
            expect(page).to have_content("youtube")
            expect(page).to have_content("quick distro")
            find("span", :text => $my_options['shout_test_demo_spec']['distro_page_2']).click
        end

        ### Add message content ###
        within(".composer") do
            fill_in "s_message", with: "This is the message content part. Vestibulum id ligula porta felis euismod semper. Curabitur blandit tempus porttitor."
        end

        ### Add a campaign ###
        within(".post-toolbar") do
            find(".icon.flag").click
        end
        within(".popout.campaign") do
            find(".select2-arrow").click
        end
        find(".select2-result-label", :text => "Automatic").click
        find(".post-title").click
        within(".post-toolbar") do
            expect(page).to have_content("Automatic")
        end

        ### Save Post ###
        find(".post-save").click
        within("#notifications") do
            expect(page).to have_content("Your post has been saved.")
        end

    end

    scenario "Find the shout in calendar and edit it" do

        ### Go to the calendar ###
        click_link("calendar")
        expect(page).to have_content("calendar")
        expect(page).to have_content("Today")
        expect(page).to have_content("Month")
        within(".menu") do
            find(".week").click
        end

        ### Click the shout we created above and click edit ###
        find("span", :text=>"This is the message").click
        within(".actions") do
            find(".edit.icon").click
        end

        ### Check to make sure the shout opened ###
        within(".composer") do
            expect(page).to have_content("This is the message content part.")
        end

        ### Add the message content the message ###
        within(".composer") do
            fill_in "s_message", with: "This is the message content part. Vestibulum id ligula porta felis euismod semper. Added something in the middle. Curabitur blandit tempus porttitor. Added on the edited part."
        end

        ### Save Post ###
        find(".post-save").click
        within("#notifications") do
            expect(page).to have_content("Your post has been saved.")
        end

        ### Check the drawer to see the new text we added ###
        within("#right-column") do
            expect(page).to have_content("This is the message content part. Vestibulum id ligula porta felis euismod semper. Added something in the middle. Curabitur blandit tempus porttitor. Added on the edited part.")
        end

    end

    scenario "Find the edited shout and delete it" do

        ### Go to the calendar ###
        click_link("calendar")
        expect(page).to have_content("calendar")
        expect(page).to have_content("Today")
        expect(page).to have_content("Month")
        within(".menu") do
            find(".week").click
        end

        ### Right click the shout we created above and click delete ###
        find("span", :text=>"This is the message").click
        within(".actions") do
            find(".delete.icon").click
        end

        ### Confirm the delete ###
        within(".shout-delete-modal") do
            click_link("delete")
        end

    end

end
