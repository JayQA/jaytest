require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include SettingsNav
include Main_nav
include Shoutbox

feature "Quick test to create a scheduled shout", :broken=>true do
    before do
        log_in_auto()
    end

    scenario "Make a shout for 4/4/14 at 5pm" do
        main_nav_calendar()
        within("#calendar-header") do
            find("a.week").click
        end
        within(".week-view") do
            find("#date-2014-04-04-17").double_click
        end
        expect(page).to have_css(".shout-modal-container.animated")
    end

end