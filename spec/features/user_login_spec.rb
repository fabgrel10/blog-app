require 'rails_helper'

RSpec.describe 'User login', type: :feature do
  before :all do
    User.destroy_all
    User.create(name: 'Dummy User', email: 'dummy@example.com', password: 'password', confirmed_at: Time.now)
  end

  before :each do
    visit new_user_session_path
  end

  context 'in the login view' do
    it 'user can see the form' do
      expect(page).to have_content('Email')
      expect(page).to have_content('Password')
      expect(page).to have_content('Log in')
    end
  end

  context 'with empty fields' do
    it 'user gets an error' do
      email_field = find_field('user[email]')
      password_field = find_field('user[password]')
      submit_button = find_button('Log in')
      expect(email_field).to_not be_nil
      expect(password_field).to_not be_nil
      expect(submit_button).to_not be_nil
    end
  end

  context 'with incorrect data' do
    it 'with incorrect email' do
      fill_in 'user[email]', with: 'wrong.user@gmail.com'
      fill_in 'user[password]', with: 'password'
      click_button 'Log in'
      expect(page).to have_text('Invalid Email or password.')
    end

    it 'with incorrect password.' do
      fill_in 'user[email]', with: 'user@gmail.com'
      fill_in 'user[password]', with: 'wrong.password'
      click_button 'Log in'
      expect(page).to have_text('Invalid Email or password')
    end
  end

  context 'with correct data' do
    it 'user signs in succesfully with the correct email and password' do
      fill_in 'user[email]', with: 'dummy@example.com'
      fill_in 'user[password]', with: 'password'
      click_button 'Log in'
      expect(current_path).to eq(root_path)
      expect(page).to have_text('Signed in successfully.')
    end
  end
end
