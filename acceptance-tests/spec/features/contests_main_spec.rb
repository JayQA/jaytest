require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav
include Helper
include Canvas
uri = 0
cgi = 0
page_id = 0
count = 0
count2 = 0

feature "Contest module" do
    before do
        log_in_auto()
    end

    scenario "Publish a contest to an everywhere page" do
        pub_everywhere_pages
        click_link("new page")
        fill_in "cd_name", :with => "Awesome Page"
        click_button("save")
        uri = URI.parse(current_url)
        cgi = CGI.parse(uri.query)
        page_id = cgi["cd_id"].first.to_s
        canvas_everywhere_addition("Everywhere")
    end

    scenario "Go to the contest and grab the number of entries" do
        contests
        # find("#erasable_0").set("everywhere" + "\n")
        fill_in "filter_name", with: ("everywhere" + "\n")
        count = find("#contest-list > div.contest > div.entries > span.count").text
    end

    scenario "Navigate to the contest and enter the contest" do
        pub_everywhere_pages
        find("a", :text => "Awesome Page").click
        within(".row.whole.column") do
            find("a", :text=> host, :match => :first).click
        end
        sleep(2)
        find("#form_533acd9436b7062d69000000 > div > div.canvas-form-elements > div.form-element-wrapper.field_0_identity.required > div > input").set("Auto")
        find("#form_533acd9436b7062d69000000 > div > div.canvas-form-elements > div.form-element-wrapper.field_1_identity > div > input").set("Capy")
        find("#form_533acd9436b7062d69000000 > div > div.canvas-form-elements > div.form-element-wrapper.field_2_identity.required.email > div > input").set("autocapy@gmail.com")
        find("#form_533acd9436b7062d69000000 > div > div.canvas-form-elements > div.canvas-submit-container > input").click
    end

    scenario "Go back into the contest and verify that the entry was received" do
        contests
        # find("#erasable_0").set("everywhere" + "\n")
        fill_in "filter_name", with: ("everywhere" + "\n")
        count2 = find("#contest-list > div.contest > div.entries > span.count").text
        if count2 <= count
            fail
        else
        end
    end

    scenario "Delete the newly created Everywhere Page" do
        pub_everywhere_pages
        check("cd_" + page_id)
        click_button("delete")
        click_button("Delete")
        expect(page).to have_no_content("Awesome Page")
    end
end