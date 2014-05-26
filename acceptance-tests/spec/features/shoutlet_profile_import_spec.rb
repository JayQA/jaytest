require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "Shoutlet Profile Import" do
    before do
        log_in_auto
    end

    def go_to_import
        find("#side-navigation li.profiles").click_link("shoutlet profiles")
        find("#side-navigation li.profiles").click_link("import profiles")
    end

    def go_to_list
        find("#side-navigation li.profiles").click_link("shoutlet profiles")
        find("#side-navigation li.profiles").click_link("list profiles")
    end

    def go_to_new_import
        go_to_import
        find(".main-content .panel").click_link("New Import")
    end

    scenario "open import page" do
        go_to_import
        expect(page).to have_css("#profile-import table")
    end

    scenario "open new import page" do
        go_to_new_import
        expect(page).to have_css("#begin-import")
        expect(page).to have_css("#contact-import-step-1")
        expect(page).to have_css("#contact-import-step-2")
        expect(page).to have_css("#SWFUpload_0")
        expect(page).to have_css("#tag-chooser", :visible => false) # :visible => false is required for have_css to work on hidden elements
        expect(page).to have_content("ADD TO SEGMENT")
        expect(page).to have_css("#overwrite")
    end

    scenario "import small csv" do
        go_to_new_import
        # page.select("CSV", :from => "#import-type") # how do

        # can't test flash in capybara
    end
end
