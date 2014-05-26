### NOTE: these tests require the new controller style, i.e. clients.shoutlet.com/:cid (no /shoutlet)
### i.e. change my_options.yml 'host' to, for example, 'https://bryan.shoutlet.com'
# as of 3/5/2014 all tests marked as :broken => true so they don't run against production; however all tests are working on the dev data set.
require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General

feature "Use a segment" do
    before do
        log_in_auto()
    end

    scenario "Navigate to the segment page", :broken => true do
        visit '/' + $my_options['default_cid'].to_s() +'/segmentation'

        within(".main-content") do
            expect(page).to have_content("SEGMENTATION")
            expect(page).to have_content('Total count')
            expect(page).to have_content('Segment count')
        end

        ### Check that some contacts are found, ###
        total_val = find("#total-count").text
        total_val.to_i.should be > 0

        ### and the initial record count is 0 ###
        found_val = find("#record-count").text
        expect(found_val).to eq("0")
        found_val.to_i.should eq(0)
    end

    scenario "Clicking the submit button will use the age filter and find some records", :broken => true do
        visit '/' + $my_options['default_cid'].to_s() +'/segmentation'

        ### Click the submit button ###
        find("#eval-criteria").click

        sleep(5) # obviously, this is dumb, but it fails without this & I don't currently know how to wait for ajax correctly.

        ### and the initial record count is 0 ###
        found_val = find("#record-count").text
        found_val.to_i.should be > 0
    end

    scenario "You can select 'must not' for the initial item, click the submit button, and return records", :broken => true do
        visit '/' + $my_options['default_cid'].to_s() +'/segmentation'

        select('must not', :from => 'logic_1')

        ### Click the submit button ###
        find("#eval-criteria").click

        sleep(5) # obviously, this is dumb, but it fails without this & I don't currently know how to wait for ajax correctly.

        ### the current data set has lots of records without an age, so this works ###
        found_val = find("#record-count").text
        found_val.to_i.should be > 0
    end

    scenario "you can select gender in the first box, choose a gender, then add another line for age, and select", :broken => true do
        visit '/' + $my_options['default_cid'].to_s() +'/segmentation'

        select('gender', :from => 'field_1')
        sleep(2)
        select('female', :from => 'search_1')
        find('#add_1').click
        sleep(1)
        select('age', :from => 'field_2')
        select('25 - 34', :from => 'search_2')

        ### Click the submit button ###
        find("#eval-criteria").click

        sleep(10) # obviously, this is dumb, but it fails without this & I don't currently know how to wait for ajax correctly.

        ### the current data set has records that match female from 25 - 34, so this works. ###
        found_val = find("#record-count").text
        found_val.to_i.should be > 0
    end


end
