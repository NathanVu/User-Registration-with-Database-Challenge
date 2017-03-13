class UserController < ApplicationController
  def index
    redirect_to '/user/show' if !session[:username].nil? && !session[:password].nil?
  end


# Story: As a internet user, I cannot register with a username that is already in use. If the username is taken, I am taken back to the registration page, which now also contains the text "Username taken, try another".

  def create
    #If there is neither a username or a password, send the user back to the previous page w/ an error message and
    #DO NOT CREATE a new User
    if params[:username].strip.empty? || params[:password].strip.empty?
      flash[:alert]="Please fill in the username and password field"
      redirect_to "/"
    # Story: As a internet user, I cannot register with a username that is already in use. If the username is taken, I am taken back to the registration page, which now also contains the text "Username taken, try another".
    elsif !User.where(username: params[:username]).empty?
      flash[:alert]="Someone has already taken that username! Please try again."
      redirect_to "/"
    else

      #Using the data we got, create and save a new User as long as they have a username and password
      user=User.new
      user.username=params[:username]
      user.password=params[:password]
      user.email=params[:email]
      user.address=params[:address]
      user.city=params[:city]
      user.state=params[:state]
      user.zip=params[:zip]
      user.country=params[:country]
      if !params[:cell_phone].strip.empty?
        ph = Phone.new
        ph.number = params[:cell_phone]
        user.phones << ph
        ph.save
      end
      if !params[:work_phone].strip.empty?
        ph = Phone.new
        ph.number = params[:work_phone]
        user.phones << ph
        ph.save
      end
      if !params[:emer_phone].strip.empty?
        ph = Phone.new
        ph.number = params[:emer_phone]
        user.phones << ph
        ph.save
      end
      session[:username] = user.username
      session[:password] = user.password
      user.save

    end

  end

  #   Story: As a registered user, I can login into the web site. If log in fails, I am taken to the log in page which now also contains the text "Log in failed, try again".
  # Hint: http://api.rubyonrails.org/classes/ActionDispatch/Flash.html

  def show
    #There are 3 conditions:
    # + 1. When a user logs in with a username and password that already belong to a previously signed-up user, it takes them to the show page for that user
    # + 2. When a user logs in with only a username or a password, it returns to the previous page and sends an error message
    # + 3. When a user logs in with a username and passwqrd that does not belong to any User, return to previous page with error message saying 'sign up'
    if !session[:username].nil? && !session[:password].nil?
      @user = User.where(username: session[:username], password: session[:password]).first
    else
      if params[:login_u].strip.empty? || params[:login_p].strip.empty?
        flash[:notice] = "You did not enter a valid username or password, please try again"
        redirect_to "/"
      else
        if User.where(username: params[:login_u], password: params[:login_p]).empty?
          flash[:notice]="This does not match anything in our datebase, please sign up"
          redirect_to "/"
        else
          session[:username] = params[:login_u]
          session[:password] = params[:login_p]
          @user = User.where(username: session[:username], password: session[:password]).first
        end
      end
    end
    
  end

  # Story: As a logged in user, I can go to a page and log out.
  # Hint: How can a user tell that they have logged out?
  def log_out
    flash[:alert] = "#{session[:username]}, you have been logged out!"
    session[:username] = nil
    session[:password] = nil
    redirect_to '/'

  end

end
