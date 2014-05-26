require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Facebook Like Test" do
    before do
        log_in_auto("mushroom")
        click_link("social crm")
        expect(page).to have_content("scrm")
    end

    scenario "Like a Facebook Post" do
        #find(:xpath, '//*[@id="stack_5420"]/div[3]/div[1]').hover
        find(:xpath, '//*[@id="stack_' + $my_options['facebook_like']['stack_id'] + '"]/div[3]/div[1]').hover

        find(".fb-like-toggle").click
        within(:xpath, '//*[@id="stack_' + $my_options['facebook_like']['stack_id'] + '"]/div[3]/div[1]') do
            expect(page).to have_content("Unlike")
        end
    end
end

