require 'rails_helper'

RSpec.feature "CreateProfiles", type: :feature do
  context "Landing Page" do
    Steps "Can create a new user when filling in all the fields" do
      Given "you start at the landing page" do
        visit '/'
        expect(page).to have_content("Profile")
      end
      When "you enter all the correct things into the form" do
        fill_in 'username', with: "Bob69"
        fill_in 'password', with: "BobIsCoolerThanU123"
        fill_in 'email', with: "Bob@bob.bob"
        fill_in 'address', with: "420 Blaze It Drive"
        fill_in 'city', with: "Single City"
        fill_in 'state', with: "CA"
        fill_in 'zip', with: "92105"
        fill_in 'country', with: "The US of A"
        click_button 'Submit'
      end


    end
  end
        # Story: As an internet user, I can go to a web site where I am presented with a registration form where username and password are required.
  # Hint: Be sure to check on the server side so a hacker can't get around the requirement
  context " require username and password" do
    Steps " Will check for username and password " do
      Given "Make sure we're on a landing page, " do
        visit '/' #visit means ok, go to wuatever route you specifiy, so "visit '/'" means go to the view that is specified on the '/' route
        expect(page).to have_content("Create Your Profile") #Expect the page we just visited to to have this string on it
      end
      When " the button is clicked make sure username and password are filled" do
        #fill_in <section of form on page visited>, withL <Whatever u want to fill it with>
        fill_in 'email', with: "Bob@bob.bob"
        fill_in 'address', with: "420 Blaze It Drive"
        fill_in 'city', with: "Single City"
        fill_in 'state', with: "CA"
        fill_in 'zip', with: "92105"
        fill_in 'country', with: "The US of A"
        click_button 'Submit' #it clicks the button whose value is 'Submit' on the page visited
      end
      Then "Give us an error message if username and password is not filled" do
        expect(page).to have_content("Please fill in the username and password field")

      end
    end
  end

  # Story: As a registered user, I can login into the web site. If log in is successful, I am taken to a page showing my registration information, with the exception of the password.

  context "Display account information" do
    Steps "access account" do
      Given "We're a registered user" do
        visit "/"
        expect(page).to have_content("Create Your Profile")
      end
      When "you put in a registered username and password into the login form" do
        fill_in 'username', with: "Bob69"
        fill_in 'password', with: "BobIsCoolerThanU123"
        fill_in 'email', with: "Bob@bob.bob"
        fill_in 'address', with: "420 Blaze It Drive"
        fill_in 'city', with: "Single City"
        fill_in 'state', with: "CA"
        fill_in 'zip', with: "92105"
        fill_in 'country', with: "The US of A"
        click_button 'Submit'
        visit "/"
        fill_in 'login_u', with: "Bob69"
        fill_in 'login_p', with: "BobIsCoolerThanU123"
        click_button 'login'
      end
      Then "it displays your account information" do
        expect(page).to have_content("Email Address: Bob@bob.bob")
      end
    end
  end
end
