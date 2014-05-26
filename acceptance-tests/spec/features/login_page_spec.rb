require File.join(File.dirname(File.expand_path(__FILE__)),'/../../spec_helper')

feature 'Visitor signs in' do
  scenario 'with valid email and password' do
    sign_up_with $my_options['login_page_spec']['email_1'],
                 $my_options['login_page_spec']['password_1']
    expect(page).to have_content('ANNOUNCEMENTS')
  end

  scenario 'with invalid email' do
    sign_up_with $my_options['login_page_spec']['email_2'],
                 $my_options['login_page_spec']['password_2']
    expect(page).to have_content('forgot your password?')
  end

  scenario 'with blank password' do
    sign_up_with $my_options['login_page_spec']['email_3'], ''
    expect(page).to have_content('forgot your password?')
  end

  def sign_up_with(email, password)
    visit '/'
    fill_in 'login_name', :with => email
    fill_in 'login_password', :with => password
    click_button 'Sign In'
  end
end
