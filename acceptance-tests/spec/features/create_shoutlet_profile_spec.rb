require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "Create single Shoutlet profile" do
    before do
        log_in_auto
    end

scenario "create new shoutlet profile" do
        click_link("shoutlet profiles")
        click_link("list profiles")
        click_link("New Contact")
        click_link("Continue")
        fill_in 'cn_first_name', :with => 'test user'
        click_button("add profile")
        expect(page).to have_content("test user")
    end
end