require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include ReportsModule

feature "New profile export section" do
    before do
        log_in_auto
        click_link("shoutlet profiles")
        click_link("export profiles")
        within(".main-section") do
            expect(page).to have_content("SHOUTLET PROFILES > EXPORT")
        end
    end

    scenario "create new export" do
        find(".open-export-contacts-new").click
        within(".modal-content.modal") do
            expect(page).to have_content("Enter a file name for the export")
        end
        @export_name = find_field('filename').value + " - " + Time.now.to_i.to_s
        fill_in("filename", :with => @export_name)
        click_on("Export Profiles")
        within(".modal-content.modal") do
            expect(page).to have_content("Your export is being created.")
        end
    end

    scenario "Check that the new export is still there" do
        within("#DataTables_Table_0") do
            expect(page).to have_content(@export_name)
        end
    end

end