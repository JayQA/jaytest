module Helper

    #host server based on my_options settings
    def host
        $my_options['host']
    end

    # git current date/time
    def helper_now
        Time.now.to_i.to_s
    end

    # take a screen shot of current screen.  names the file with unix time stamp
    def helper_screenshot
        page.save_screenshot("screenshots/#{helper_now}.png")
    end

    def helper_html
        save_and_open_page
    end

    #confirming alerts in either Selenium or Webkit
    def helper_alert_confirm
        if Capybara.default_driver == :selenium
            page.driver.browser.switch_to.alert.accept
        else
            page.driver.browser.accept_js_confirms
        end
    end

    #Execute a section of the test when needing to work with a newly created window
    def helper_switch_to_new_window(&block)
        if Capybara.default_driver == :selenium
            page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
            yield
            page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
        else
            page.driver.browser.window_focus(page.driver.browser.get_window_handles.last)
            yield
            page.driver.browser.window_focus(page.driver.browser.get_window_handles.first)
        end
    end

    def helper_set_window_size(x, y)
        if Capybara.current_driver == :selenium
            set_selenium_window_size(x, y)
        else
            set_webkit_window_size(x, y)
        end
    end

end