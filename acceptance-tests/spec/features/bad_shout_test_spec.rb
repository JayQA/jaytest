require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Create and distribute shouts" do
    before do
        log_in_auto()
    end

    ### First Shout ###

    scenario "create and save a new shout" do
        # page.execute_script("window.scroll(0,200000)")
        within("#header") do
            find("#global-post-button").click
        end
        within(".shout-modal-container") do
            expect(page).to have_content("save post")
        end
        ### Shout title ### Commented out because send_keys only works in selenium
        find(".post-title").click
        find(".post-title").set "first post test"

        ### Add Network to shout ###
        find("#s2id_autogen3").click
        within(".destination-dropdown") do
            expect(page).to have_content("facebook")
            expect(page).to have_content("twitter")
            expect(page).to have_content("youtube")
            expect(page).to have_content("quick distro")
            find("span", :text => $my_options['bad_shout_test_spec']['distro_page_1']).click
        end

        ### Add second network to shout ###
        find("#s2id_autogen3").click
        within(".destination-dropdown") do
            expect(page).to have_content("facebook")
            expect(page).to have_content("twitter")
            expect(page).to have_content("youtube")
            expect(page).to have_content("quick distro")
            find("span", :text => $my_options['bad_shout_test_spec']['distro_page_2']).click
        end

        ### Add the message content the message  ###
        within(".composer") do
            fill_in "s_message", with: "This is the message content part. Vestibulum id ligula porta felis euismod semper. Curabitur blandit tempus porttitor."
        end

        # # ### Scheduling ###
        # # within(".post-toolbar") do
        # #     find(".icon.clock").click
        # # end
        # # within(".ui-datepicker-calendar") do
        # #     find("a", :text => "31").click
        # # end
        # # within(".hour-select") do
        # #     select("11")
        # # end
        # # within(".minute-select") do
        # #     select("59")
        # # end
        # # within(".period-select") do
        # #     select("pm")
        # # end
        # # find(".post-title").click
        # # within(".post-toolbar") do
        # #     expect(page).to have_content("January 31, 2014 11:59 pm")
        # # end

        # ### Campaign ###
        # within(".post-toolbar") do
        #     find(".icon.flag").click
        # end
        # within(".popout.campaign") do
        #     find(".select2-arrow").click
        # end
        # find(".select2-result-label", :text => "Automatic").click
        # find(".post-title").click
        # within(".post-toolbar") do
        #     expect(page).to have_content("Automatic")
        # end

        # ### Tags ### Commenting out because send_keys is only selenium
        # within(".post-toolbar") do
        #     find(".icon.tag").click
        # end
        # within(".popout.tags.open") do
        #     find(".select2-search-field").click
        #     find(".select2-input").native.send_keys "automatedtag"
        # end
        # find(".select2-result-label", :text => "automatedtag").click
        # find(".post-title").click
        # within(".post-toolbar") do
        #     expect(page).to have_content("1 tag")
        # end

        # ### Facebook Targeting ###
        # within(".post-toolbar") do
        #     find(".icon.facebook-target").click
        # end
        # within(".popout.facebook-targeting.open") do
        #     expect(page).to have_content("facebook targeting")
        #     find(".target-group.post-dialog-select2-container").click
        # end
        # within(".targeting.facebook-targeting") do
        #     find(".select2-choice").click
        # end
        # find(".select2-result-label", :text => "non-montana").click
        # within(".targeting.facebook-targeting") do
        #     expect(page).to have_content("Geotargeting")
        #     expect(page).to have_content("United States")
        #     expect(page).to have_content("Montana")
        # end
        # find(".post-title").click
        # within(".post-toolbar") do
        #     expect(page).to have_content("1 target")
        # end

        ### Save Post ###
        # page.execute_script(%Q{$("#scrollElement").prop("scrollTop", 1000000).trigger('scroll')})
        # Capybara.current_session.driver.execute_script("arguments[0].scrollIntoView(true;)", find_button("Save").native)
        # page.execute_script("window.scroll(0,200000)")
        # find(".post-save").click
        # within("#notifications") do
        #     expect(page).to have_content("Your post has been saved.")
        # end
        # within(".footer") do
        #     find(".button.charcoal").click
        # end

        ### Publish Post ###
        find(".button.post-save").click

    end

end
