class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create    
    if params[:provider].present? && params[:provider]=="facebook"
      user = User.from_omniauth(env["omniauth.auth"])
      @user_session = UserSession.new(:email => user.email, :password => user.password)
    else  
      @user_session = UserSession.new(params[:user_session])
    end  
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to posts_path
    else
      render :action => :new
    end
  end

  def google_signin
    response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(
        :identifier => "https://www.google.com/accounts/o8/id",
        :required => ["http://axschema.org/contact/email",
                      "http://axschema.org/namePerson/first",
                      "http://axschema.org/namePerson/last"],
        :return_to => google_create_url,
        :method => 'POST')
    head 401
  end  

  def google_create
    if (openid = request.env[Rack::OpenID::RESPONSE]) && (openid.status == :success)      
      if user = User.from_google(openid)         
        @user_session = UserSession.create(:email => user.email , :password => openid.display_identifier.split('=').last)        
        redirect_to posts_path
      end  
    else
      redirect_to :controller => 'user_sessions',:action => 'new',:notice => "Authentication Error"        
    end    
  end  

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :controller => 'user_sessions', :action => 'new'
  end
end
