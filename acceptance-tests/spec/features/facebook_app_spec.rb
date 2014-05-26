require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Helper
include Canvas
include Library
uri = 0

feature "Facebook App Spec"  do
    before do
        log_in_auto()
    end
    
    scenario "Create a canvas" do
        main_nav_canvas
        sleep(1)
        expect(page).to have_content("Welcome to Social Canvas")
        find(".close-modal").click
        find("#add_mod_text").click
        find("#canvas-document-background").click
        within("#_modal_edit_object") do
            find("#text_data").set("Check out this slick Canvas!")
            click_button("okay")
        end
        click_link("File")
        find("#canvas-save").click
        within("#_modal_ask_to_save") do
            fill_in "blank-canvas-name", :with => "Auto Canvas"
            click_button("okay")
        end
        helper_alert_confirm
        sleep(1)
        expect(page).to have_no_content("saving")
    end

    scenario "Publish the canvas to the App" do
        pub_apps
        find("a", :text => "Automated Tab").click
        canvas_fb_app_addition("Auto Canvas")
    end

    scenario "Verify that the canvas is live" do
        pub_apps
        find("a", :text => "Automated Tab").click
        within(".main-content") do
            find("a", :text=> host, :match => :first).click
        end
        sleep(3)
        helper_switch_to_new_window{
            fill_in "email", :with=> "adam.pergande@shoutlet.com"
            fill_in "pass", :with => "Badgers80" + "\n"
            sleep(2)
            within_frame(find("#pagelet_app_runner > iframe")) do
                expect(page).to have_content("Check out this slick Canvas!")
            end
        }
    end

    scenario "Deactivate the canvas" do
        pub_apps 
        find("a", :text => "Automated Tab").click
        canvas_deactivate
    end

    scenario "Delete the Canvas from the Library" do
        main_nav_library
        click_link("canvas designs")
        library_delete("Auto Canvas")
        sleep(2)
        expect(page).to have_content("No results matched your search term.")
    end

end