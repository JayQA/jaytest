require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

feature "Vote on contests" do

    scenario "Attempt to vote on a contest with captcha enabled" do

        url = "https://" + $my_options['host'] + ".shoutlet.com/service/v2/canvas_builder/load?id=53582458b59ef4c14c000004"

        visit(url)
        expect(page).to have_content("Custom test to key test off of.")

        within("div.ce_entries") do
            find("div:nth-child(2) > div > div.ce_vote > a").click
        end
        expect(page).to have_css("#recaptcha_area")

        find("#recaptcha-submit-button").click
        within("#canvas-notifications") do
            expect(page).to have_content("Sorry, but the reCaptcha response you answered was incorrect.")
        end

    end

    scenario "Attempt to vote on a contest with FB Verification enabled" do

        url = "https://" + $my_options['host'] + ".shoutlet.com/service/v2/canvas_builder/load?id=53583cd8b59ef44a4f000004"

        visit(url)
        expect(page).to have_content("FB Vote Contest test.")

        within("div.ce_entries") do
            @pre_vote_count = find("div:nth-child(2) > div > div.ce_vote_total").text.split(' ')[0].strip().to_i()
            find("div:nth-child(2) > div > div.ce_vote > a").click
        end

        if Capybara.default_driver == :selenium
            page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
            expect(page).to have_content("Log in to use your Facebook account")
            fill_in "email", :with => "bill.cumin@gmail.com"
            fill_in "pass", :with => "Shout123"
            click_on "Log In"
            page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
        else
            within_window(page.driver.browser.get_window_handles.last) do
                expect(page).to have_content("Log in to use your Facebook account")
                fill_in "email", :with => "bill.cumin@gmail.com"
                fill_in "pass", :with => "Shout123"
                click_on "Log In"
            end
        end

        within("#canvas-notifications") do
            expect(page).to have_content("Thank You")
        end

        within("div.ce_entries") do
            new_vote_count = find("div:nth-child(2) > div > div.ce_vote_total").text.split(' ')[0].strip().to_i()
            expect(new_vote_count).to eq(@pre_vote_count + 1)
        end

    end

end