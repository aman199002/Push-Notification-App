class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
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
    if openid = request.env[Rack::OpenID::RESPONSE]      
      if openid.status == :success
        ax = OpenID::AX::FetchResponse.from_success_response(openid)
        user = User.where(:identifier_url => openid.display_identifier).first
        user ||= User.create!(:identifier_url => openid.display_identifier,
                              :email => ax.get_single('http://axschema.org/contact/email'),
                              :first_name => ax.get_single('http://axschema.org/namePerson/first'),
                              :last_name => ax.get_single('http://axschema.org/namePerson/last'),
                              :password => openid.display_identifier.split('=').last,
                              :password_confirmation => openid.display_identifier.split('=').last
                              )
        @user_session = UserSession.create(:email => user.email , :password => openid.display_identifier.split('=').last)
      end    
      redirect_to posts_path
    end
  end  

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to :controller => 'user_sessions', :action => 'new'
  end
end
