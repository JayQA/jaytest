require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Shoutbox
include Helper
include Main_nav

@custom_text = ''

feature 'Use the bookmarklet' do

    scenario "Open a link and use the bookmarklet to create a shout" do
        log_in_auto

        visit("http://www.theuselessweb.com/")
        click_button "PLEASE"
        story_url = current_url

        execute_script("javascript:d=new Date();void(window.open('https://" + $my_options['host'] + ".shoutlet.com/shoutlet/bookmark?date='+d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()+'&title='+window.document.title+'&message='+window.location,'_new','toolbar=no,scrollbar=yes,resizable=yes,height=655,width=800'));")

        helper_switch_to_new_window{
            # Can't use class methods because the select2 id is different
            # shoutbox_destination("Full Price Books")
            find("#s2id_autogen2").click
            within(".destination-dropdown") do
                find("span", :text => "Full Price Books").click
            end
            default_text = find(".message").value
            @custom_text = Time.now.to_i.to_s + " " + default_text
            shoutbox_title("Made from the bookmarklet")
            shoutbox_message(@custom_text)
            find(".shout-modal-container").click
            helper_set_window_size(800, 800)
            shoutbox_post
            Capybara.reset_sessions!
        }
        Capybara.reset_sessions!

    end

    scenario "Examine and delete the shout created by the bookmarklet" do
        log_in_auto
        helper_set_window_size(2000, 800)

        main_nav_calendar

        if !have_css?(".week.active")
            within("#calendar-header") do
                find(".week").click
            end
        end

        within(".scrollable") do
            find("span", :text => "Made from the bookmarklet").click
        end

        within(".message") do
            expect(page).to have_content(@custom_text)
        end

        find(".delete.icon").click
        within(".shout-delete-modal") do
            find(".button.warning").click
        end

    end

end