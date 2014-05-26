require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

uri = 0
# Capybara.default_wait_time = 60

feature "Workflow Administration Section" do
    before do
        log_in_auto()
        click_link("administration")
        click_link("workflow")
        within(".main-section.top") do
            expect(page).to have_content("WORKFLOWS")
        end
    end

    scenario "Workflow Creation", :broken => true do
        click_on "new workflow"
        # take_screenshot("/tmp/screenshot1")
        expect(page).to have_content("WORKFLOW - NEW")
        within("#tabedit") do
            fill_in "work_name", :with => "Capy Workflow"
        end
        find(".ui-button-icon-primary.ui-icon.ui-icon-triangle-1-s").click
        within(".ui-autocomplete.ui-menu.ui-widget.ui-widget-content.ui-corner-all") do
            find("a" , :text => "Default Publisher").click
        end
        click_link("add-a-role")
        expect(page).to have_css("#role-#{$my_options['workflow_admin_spec']['role_id']}") # unique ID for role
        click_button("save")
        uri = URI.parse(current_url).path.split('/').last.to_s
        click_link("workflow")
        within(".default.checklist.no-avatar") do
            expect(page).to have_content("Capy Workflow")
        end

    end

    scenario "Workflow Deletion", :broken => true do
        # puts uri
        within(".default.checklist.no-avatar") do
            check("workflow_" + uri)
        end
        click_button("delete")
        click_button("Delete")
        expect(page).to have_no_content("Capy Workflow")
     end
end
