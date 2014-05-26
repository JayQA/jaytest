require 'rubygems'
require 'bundler/setup'

require 'rspec'
require 'capybara/rspec'
# require 'selenium-webdriver'
require 'capybara-webkit'
# require 'capybara-screenshot'
# require 'capybara-screenshot/rspec'
require 'headless'
require 'debugger'

# require all class files
Dir[File.dirname(__FILE__) + '/spec/classes/*.rb'].each {|file| require file }

# use options.yaml to load your own defaults.
require 'yaml'
$my_options = YAML.load(File.read('my_options.yml'))

### Edit these settings to determine what config settings are used ###
local = $my_options['local']
selenium = $my_options['selenium']

### Driver settings ###
if selenium
    Capybara.default_driver = :selenium
else
    Capybara.default_driver = :webkit
end
Capybara.javascript_driver = :webkit

Capybara.app_host = $my_options['basic_host']
Capybara.default_wait_time = $my_options['wait_time']
Capybara.save_and_open_page_path = "./screenshots"

def set_selenium_window_size(width, height)
    window = Capybara.current_session.driver.browser.manage.window
    window.resize_to(width, height)
end

def set_webkit_window_size(width, height)
    page.driver.resize_window(width, height)
    # page.driver.enable_logging
end

RSpec.configure do |config|
    config.before(:each) do
        set_selenium_window_size(1250, 800) if Capybara.current_driver == :selenium
        set_webkit_window_size(1250, 800) if Capybara.current_driver == :webkit
    end

    config.after(:each) do
        if example.exception != nil and $my_options['debug'] == true
            save_page
            page.save_screenshot('screenshots/' + Time.now.to_i.to_s + '.png')
        end
    end

    config.filter_run_excluding :broken => true

    # config.after(:each) do
    #     Capybara.reset_sessions!
    # end

    if !local
        config.before(:suite) do
            $headless = Headless.new
            $headless.start
        end

        at_exit do
            $headless.destroy
        end
        # config.after(:suite) do
        #     @headless.destroy
        # end
        # config.after(:each) do |scenario|
        #     if scenario.failed? and $my_options['local'] == true
        #         headless.take_screenshot("/tmp/#{BUILD_ID}/#{scenario.name.split.join("_")}")
        #     end
        # end
    end

end

# ### Adds a context_click method to right click items, only works in selenium ###
# module Capybara
#   module Node
#     class Element
#       def context_click
#         @session.driver.browser.action.context_click(self.native).perform
#       end
#     end
#   end
# end

### Overriding the invalid_element_errors so  ###
if Capybara.current_driver == :webkit
    module Capybara
        module Webkit
            class Driver
                def invalid_element_errors
                    [Capybara::Webkit::ClickFailed, Capybara::Webkit::NodeNotAttachedError]
                end
            end
        end
    end
end

class User
    include Capybara::DSL

    attr_accessor :email, :password, :cid

    def initialize(email, password, cid)
        @email = email
        @password = password
        @cid = cid
    end

    def login(server, user = self)
        if server === '' then
            server = $my_options['host']
        end

        if $my_options['host_override'] === true then
            Capybara.app_host = "https://" + $my_options['host'] + ".shoutlet.com/shoutlet"
        else
            Capybara.app_host = "https://" + server + ".shoutlet.com/shoutlet"
        end

        visit '/'
        fill_in 'login_name', :with => user.email
        fill_in 'login_password', :with => user.password
        click_button 'Sign In'
    end
end

### Modules for common actions ###

module General
    include Capybara::DSL

    def log_in_auto(server = '')
        @auto = User.new($my_options['default_user_email'],
                         $my_options['default_user_password'],
                         $my_options['default_cid'] )
        @auto.login(server)
        expect(page).to have_content("ANNOUNCEMENTS")
        expect(page).to have_content($my_options['default_user_name'])
    end

    def log_in_admin(server = '')
        @admin = User.new($my_options['admin_user_email'],
                          $my_options['admin_user_password'],
                          $my_options['admin_cid'])
        @admin.login(server)
        expect(page).to have_content("ANNOUNCEMENTS")
        expect(page).to have_content($my_options['admin_user_name'])
    end

    def log_in_author(server = '')
        @author = User.new($my_options['author_user_email'],
                          $my_options['author_user_password'],
                          $my_options['author_cid'])
        @author.login(server)
        expect(page).to have_content("ANNOUNCEMENTS")
        expect(page).to have_content($my_options['author_user_name'])
    end

    def log_in_sub(server = '')
        @sub = User.new($my_options['sub_user_email'],
                          $my_options['sub_user_password'],
                          $my_options['sub_cid'])
        @sub.login(server)
        expect(page).to have_content("ANNOUNCEMENTS")
        expect(page).to have_content($my_options['sub_user_name'])
    end

    def log_in_clients_standard(server = '')
        @admin = User.new("autocapy+live_standard@gmail.com", "Shout123", "15968")
        if server === '' then
            @admin.login("clients")
        else
            @admin.login(server)
        end
        expect(page).to have_content("ANNOUNCEMENTS")
        expect(page).to have_content("auto capy")
    end
end

module SettingsNav
    include Capybara::DSL

    def go_to_settings
        find(:css, '.client-name').click
        click_on "Settings"
        expect(page).to have_content("OVERVIEW")
    end
end

module ReportsModule
    include Capybara::DSL

    def select_subaccounts
        page.should have_content("SELECT FILTERS")
        find('th.checkboxes > div > input[type="checkbox"]').set(true)
        find("#submitMap").click
    end
end
