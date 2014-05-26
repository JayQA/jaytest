require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Main_nav

feature 'Create a contest' do
    before do
        #@auto = User.new("capybara@shoutlet.com", "Shout123_", "2166")
        #@auto.login()

        # does this test need a specific user/cid for any reason? if not just use log_in_auto.
        # otherwise add the needed login/password/CID to an array called create_blank_contest in my_options.yml
        log_in_auto()
    end

    # Adding the broken tag, can't create new contest without wizard since 5/7/14. GBL
    scenario 'without using a template or the wizard', :broken => true do
        contests()
        find('#new-contest-app').click
        find('.skip-wizard').click
        find('.add-phase').click
        find('.phase-name').set('Entry')
        within("#phase_modal") do
            find('.save').click
        end
        find('#config-submit').click
        find('.add-design').click
        find('.okay').click
        find('#canvas-document-background')

        #find('li.contest .expander').click
        #find('#add_mod_contest_entry').click
        #find('#canvas-document-background').click
        #within('#_modal_edit_object') do
        #    find('.modal-button-ok').click
        #end
        #within('#editor-main-controls') do
        #    click_link('File')
        #    find('#canvas-save').click
        #end
        #within('#_modal_ask_to_save') do
        #    find('.modal-button-ok').click
        #end

        page.evaluate_script("var test = new Shoutlet.canvas_contest_entry( canvas ); test.drop_absolute(0, { top: 50, left: 50 }); test.save(); canvas.save();")
        find('li.contest .expander')
        page.evaluate_script("var test = new Shoutlet.canvas_contest_entry( canvas ); test.drop_absolute(1, { top: 100, left: 100 });")
        find('li.contest .expander')
        expect(page).to have_content("Only a single voting module can be placed on a page.")
    end
end
