require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')
include General

feature "Admin Pannel Tests" do
    before do
        log_in_admin()
        find(".client-name").click
        within("#profile-menu") do
            find("a", :text => "Admin").click
        end
        expect(page).to have_content("CLIENT MANAGEMENT")
    end

    ### Beginning of Admin Tests ###

    # scenario "Testing split to get the cid of a new account" do
    #     visit "/admin/client_edit/5940"
    #     url = current_path.split('/')
    #     puts url
    #     true
    # end

    scenario "create a new enterprise client" do
        find("a", :text => "NEW CLIENT").click
        expect(page).to have_content("CLIENTS > NEW CLIENT")
        fill_in("c_name", :with => "ZZZ Automatic Regression Enterprise ZZZ")
        select("agency", :from => "c_cp_id")
        check("flag_active")
        page.execute_script("window.scroll(0,2000000)")
        click_on("save")
        expect(page).to have_content("CLIENTS > ZZZ AUTOMATIC REGRESSION ENTERPRISE ZZZ")
        expect(page).to have_content("multi-account")
        page.should have_checked_field("flag_active")
    end

    # scenario "create a new parent account user" do
    #     true
    # end

    # scenario "add a new user to an account " do
    #     true
    # end

    # scenario "add an exisiting user to an account" do
    #     true
    # end

    # scenario "remove a user from an account" do
    #     true
    # end

    # scenario "impersonate an account" do
    #     true
    # end

    # scenario "deactivate a user" do
    #     true
    # end

    # scenario "deactivate an account" do
    #     true
    # end

end
