require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

uri = 0

feature "Roles Administration Section" do
    before do
        log_in_auto()
        click_link("administration")
        click_link("roles")
        within(".main-section.top", :match => :first) do
        	expect(page).to have_content("ROLES")
        end
    end

    scenario "Role Creation" do
    	click_link("new global role")
    	fill_in "role_name", :with => "Capy Role"
    	page.check("permissions-check")
    	click_button("save")
    	within(".default.checklist.no-avatar.one.dataTable") do
			expect(page).to have_content("Capy Role")
		end
    end

    scenario "Add a User to a Role" do
    	click_link("Capy Role")
    	click_button("add_user_to_role")
    	find(".ui-button-icon-primary.ui-icon.ui-icon-triangle-1-s").click
    	within(".ui-autocomplete.ui-menu.ui-widget.ui-widget-content.ui-corner-all") do
			find("a" , :text => "Auto Capy").click
		end
		click_button("Add")
		find("a" , :text => "OKAY").click
		within(".whole.column") do
			expect(page).to have_content("Auto Capy")
		end
		uri = URI.parse(current_url).path.split('/').last.to_s
    end

    scenario "Remove a User from a Role" do
    	click_link("Capy Role")
    	page.check("workflow")
    	click_button("delete_from_list")
    	click_button("Delete")
    	within(".whole.column") do
    		expect(page).to have_no_content("Auto Capy")
    	end
    end

    scenario "Delete a Role" do
    	within(".default.checklist.no-avatar.one.dataTable") do
    		page.check("role_" + uri)
    	end
    	click_button("delete_from_list", :match => :first)
    	click_button("Delete")
    	expect(page).to have_no_content("Capy Role")
    end


end
