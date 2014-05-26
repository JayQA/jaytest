module Shoutbox

  def shoutbox_open
    within("#header") do
      find("#global-post-button").click
    end

    within(".shout-modal-container") do
      expect(page).to have_content("save post")
    end

  end

  def shoutbox_close
    find(".close-button").click

  end

  def shoutbox_save
    find(".post-save").click
    sleep 5
  end

  def shoutbox_post
    find(".post-submit").click
    sleep 5
  end

  def shoutbox_message(message)
    within(".composer") do
      fill_in "s_message", with: message
    end
  end

  def shoutbox_title(title)
    find(".post-title").set title
  end

  def shoutbox_destination(dest)
    find("#s2id_autogen3").click
    within(".destination-dropdown") do
      find("span", :text => dest).click
    end

  end

  def shoutbox_destinations
    find("#s2id_autogen3").click
    within(".destination-dropdown") do
      find("span", :text => "Full Price Books").click
    end

    find("#s2id_autogen3").click
    within(".destination-dropdown") do
      find("span", :text => "Bill_Cumin").click
    end
  end

  def shoutbox_twitter_custom(message)
    find(".icon.twitter-message").click
    fill_in "s_tweet", with: message
  end

  def shoutbox_campaign(campaign)
    find(".icon.flag").click
    within(".popout.campaign") do
      find(".select2-arrow").click
    end
    find(".select2-result-label", :text => campaign).click
  end 

  def shoutbox_tag(tag)
    find(".icon.tag").click
    within(".popout.tags") do
      find(".select2-choices").click
    end
    find(".select2-result-label", :text => tag).click
  end

  def shoutbox_facebook_target(target)
    find(".icon.facebook-target").click
    within(".popout.targeting.facebook-targeting") do
      find(".select2-arrow").click
    end
    find(".select2-result-label", :text => target).click
  end

  def shoutbox_gplus_target(target)
    find(".icon.gplus-target").click
    within(".popout.gplus-targeting") do
      find(".select2-choices").click
    end
    find(".select2-result-label", :text => target).click
  end

  def shoutbox_twitter_target(target)
    find(".icon.twitter-target").click
    within(".popout.targeting.twitter-targeting") do
      find("#twitter_targeting_input").click
      sleep(2)
      within(".target_results") do
        find("span", :text => target, :match => :first).click
      end
    end
  end


end
