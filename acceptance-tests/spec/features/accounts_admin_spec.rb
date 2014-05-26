require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
now = Time.now.asctime
uri = 0

feature "Use the account administration section to... " do
    before do
        log_in_admin()
        wf_accounts
        within(".main-section.top") do
            expect(page).to have_content("ALL ACCOUNTS")
        end
    end

    scenario "Search for a sub account" do
        within("#account_search_form") do
            fill_in "c_name", with: "first"
            click_button "go"
        end
        within(".default.checklist") do
            expect(page).to have_content("First")
            expect(page).to have_no_content("Second")
        end
    end

    # scenario "Load the Edit sub account page" do
    #     # find(:xpath, '//*[@id="container"]/div[2]/div[2]/table/tbody/tr[2]/td[6]/nobr/a[1]').click
    #     within(".inactive") do
    #         click_link "edit"
    #     end
    #     expect(page).to have_selector(".client-edit_sub_account")
    #     within(".client-edit_sub_account") do
    #         find_field("c_name").value.should eq "Fourth Account - Going to Inactivate"
    #     end
    # end

    # scenario "Login to the sub account" do
    #     find(:xpath, '//*[@id="container"]/div[2]/div[2]/table/tbody/tr[2]/td[6]/nobr/a[2]').click
    #     within(".client-name") do
    #         expect(page).to have_content("First Sub Account Created")
    #     end
    # end

    # scenario "Filter by inactive" do
    #     within("#account_search_form") do
    #         select("inactive", :from => "type")
    #     end
    #     within(".default.checklist") do
    #         expect(page).to have_content("Fourth")
    #         expect(page).to have_no_content("Second")
    #     end
    # end

    # scenario "Filter by archived" do
    #     within("#account_search_form") do
    #         select("archived", :from => "type")
    #     end
    #     within(".default.checklist") do
    #         expect(page).to have_content("Third")
    #         expect(page).to have_no_content("Second")
    #     end
    # end

    scenario "Sub Account Creation" do
        click_link("new account")
        find("#c_name").set("Capy Account " + now)
        page.check("permissions-check")
        click_button("save")
        within("#side-navigation") do
            click_link("accounts")
        end
        within(".default.checklist.no-avatar") do
            expect(page).to have_content("Capy Account " + now)
        end
    end

    scenario "Create a user and add to a sub account" do
        fill_in "c_name", :with => "Capy Account"
        click_button("go")
        find("a", :text=> "edit").click
        click_link("add new user")
        fill_in "cn_first_name", :with => "New"
        fill_in "cn_last_name", :with => "User " + now
        fill_in "su_email", :with => "newuser" + now + "@gmail.com"
        fill_in "su_password1", :with => "Shout123"
        fill_in "su_password2", :with => "Shout123"
        click_button("save")
        workflow_main
        wf_accounts
        fill_in "c_name", :with => "Capy Account"
        click_button("go")
        find("a", :text=> "edit").click
        expect(page).to have_content("User " + now)
        uri = URI.parse(current_url).path.split('/').last.to_s
    end

    scenario "Archive the account" do
        fill_in "c_name", :with => "Capy Account"
        click_button("go")
        check("c_" + uri)
        click_link("actions")
        find("a", :text => "archive").click
        within("#shoutlet-modal") do
            click_button("Archive")
        end
        expect(page).to have_no_content("Capy Account " + now)
    end

    scenario "Change Permissions on a sub account" do
        fill_in "c_name", :with => "Sub account for Sub User"
        click_button("go")
        find("a", :text=> "edit").click
        find("#client_form > div:nth-child(15) > div:nth-child(1) > table > thead > tr > th.checkboxes > div > input[type='checkbox']").set(false)
        click_button("save")
        within("#client_form > div:nth-child(15) > div:nth-child(1) > table") do
            all('input[type=checkbox]').each do |checkbox|
                checkbox.should_not be_checked
            end 
        end
        within(".main-section.top") do
            click_link("accounts")
            expect(page).to have_content("ALL ACCOUNTS")
        end
        fill_in "c_name", :with => "Sub account for Sub User"
        click_button("go")
        find("a", :text=> "login").click
        expect(page).to have_no_content("STATUS")
        expect(page).to have_no_content("AVAILABLE MEDIA")
        within("#header") do
            find(".logo").click
        end
        within("#profile-menu") do
            find("a", :text => "Automated Parent Account").click
        end
        wf_accounts
        fill_in "c_name", :with => "Sub account for Sub User"
        click_button("go")
        find("a", :text=> "edit").click
        find("#client_form > div:nth-child(15) > div:nth-child(1) > table > thead > tr > th.checkboxes > div > input[type='checkbox']").set(true)
        click_button("save")
        within("#client_form > div:nth-child(15) > div:nth-child(1) > table") do
            all('input[type=checkbox]').each do |checkbox|
                checkbox.should be_checked
            end 
        end
    end

end
