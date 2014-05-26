require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Twitter Favorite Test" do
    before do
        log_in_auto("mushroom")
        click_link("social crm")
        expect(page).to have_content("scrm")
    end

    scenario "Favorite a Tweet" do
        find(:xpath, '//*[@id="stack_' + $my_options['twitter_favorite']['stack_id'] + '"]/div[3]/div[1]/p').hover

        find(".tweet-favorite-toggle").click
        within(:xpath, '//*[@id="stack_' + $my_options['twitter_favorite']['stack_id'] + '"]/div[3]/div[1]/ul/li[2]/a') do
            expect(page).to have_content("Unfavorite")
        end
    end
end

