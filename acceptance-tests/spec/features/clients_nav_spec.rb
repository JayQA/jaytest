require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav

feature "General navigation on clients", :clients => true do
    before do
        log_in_clients_standard
    end

    scenario "Go to SCRM v2" do
        main_nav_scrm
        expect(page).to have_content("Default Board")
        within("#stack_69407") do
            expect(page).to have_content("Full Price Books")
        end
    end

    scenario "Go to canvas and create a new blank design" do
        main_nav_canvas
        within(".welcome-selection") do
            expect(page).to have_content("Welcome to Social Canvas")
            find("p", :text => "canvas design").click
        end
        # expect(page).to have_content("PLEASE NAME YOUR CANVAS DESIGN")
        now = Time.now.asctime
        design_name = "Automated design - " + now
        fill_in "name", :with => design_name
        find(".modal-button-ok.button").click
        within("#canvas-name-display") do
            expect(page).to have_content(design_name)
        end
    end
end