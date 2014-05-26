require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Shoutbox
include Helper
include Library

now = Time.now.to_i.to_s

feature "Parent Sharing down spec" do

    scenario "Create a shout on a Parent account and share down to the sub" do
        log_in_auto()
        shoutbox_open
        shoutbox_message("Shout to be shared down " + now)
        shoutbox_save
        shoutbox_close
        main_nav_library
        click_link("shouts")
        library_search("Shout to be shared down " + now)
        library_share
        within("#contentManager-shoutlet-share-objects-modal") do
            find(".ff-share-select.ff-share-select-20932").set(true)
            library_share_modal
        end
        expect(page).to have_no_content("#contentManager-shoutlet-share-objects-modal")
        sleep(2)
    end

    scenario "On the sub account find the shared shout send it to the calendar and delete it" do
        log_in_sub()
        main_nav_library
        click_link("shouts")
        find("span", :text => "shared content").click
        sleep(1)
        library_dist("Shout to be shared down " + now)
        expect(page).to have_content("Month")
        find("span", :text => "Shout to be shared down " + now).click
        within("#right-column") do
            expect(page).to have_content("Draft")
        end
        within(".actions") do
            find(".delete.icon").click
        end
        within(".shout-delete-modal") do
            click_link("delete")
        end
    end

    scenario "Clear out the shout from the library on the Parent account" do
        log_in_auto()
        main_nav_library
        click_link("shouts")
        library_delete("Shout to be shared down " + now)
        sleep(2)
        expect(page).to have_content("No results matched your search term.")
    end

end