module Canvas
    
    #add a canvas page to a Facebook app and activate
    def canvas_fb_app_addition(canvas)
        find("a", :text => "(add page)").click
        within("#shoutlet-modal") do
            sleep(2)
            find("#pages_finder > div.ff-header.hideFilter > div.ff-search > input").set(canvas + "\n")
            find("#pages_finder > div.ff-body > div.ff-object-listing > div > div.ff-object.shout > div.ff-object-img").click
            click_link("done")
        end
        canvas_activate
    end

    #add a canvas page to an everywhere page and activate
    def canvas_everywhere_addition(canvas)
        find("a", :text => "(add page)").click
        within("#shoutlet-modal") do
            sleep(2)
            find("#pages_finder > div.ff-header.hideFilter > div.ff-search > input").set(canvas + "\n")
            find("#pages_finder > div.ff-body > div.ff-object-listing > div > div.ff-object.shout").click
            click_link("done")
        end
        canvas_activate
    end

    #Activate a canvas/contest when it is the only one added to an everywhere page/Facebook app
    def canvas_activate
        find(".shoutlet-tooltip.design").hover
        within(".shoutlet-tooltip.design") do
            find("a", :text=> "activate").click
        end
        expect(page).to have_no_content("NO ACTIVE DESIGNS")
    end

    #Deactivate the currently active canvas and verify that they page has no canvases
    def canvas_deactivate
        find(".shoutlet-tooltip.design.active").hover
        within(".shoutlet-tooltip.design.active") do
            find("a", :text=> "deactivate").click
        end
        expect(page).to have_content("NO ACTIVE DESIGNS")
    end

end