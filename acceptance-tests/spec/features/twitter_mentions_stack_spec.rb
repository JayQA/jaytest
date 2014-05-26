require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

include General
include Vantage

board_name = "Twitter_Mention_Board"

feature "Twitter Mentions Stack Test" do
    before do
        log_in_auto("mushroom")
        click_link("social crm")
        expect(page).to have_content("Automated Parent Account Board")
    end

    scenario "Create a Twitter Mentions Stack" do
        # Create an empty board to put the new stack on
        new_board(board_name)
        select_board(board_name)

        # Create the stack
        new_stack(:network => "Twitter", :account => "Bill_Cumin", :stream => "Mentions")
        expect(page).to have_content("Mentions")

        # Clean up; Delete Board
        delete_board(board_name)
    end
end