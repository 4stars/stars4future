class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_auth(request.env["omniauth.auth"])
    if @user.blank?
       redirect_to new_registration_path(resource_name),:flash=>{:notice=>"Email Already in Use, Try with other"}
    else
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      if @user.username.blank?
        session["fb_user_signup"] = true
        session["fb_user_name"]=@user.profile.first_name
        sign_in_and_redirect @user, :event => :authentication
      else
        sign_in_and_redirect @user, :event => :authentication
      end
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to pages_path
    end
    end
#    @memo = @user.memo
  end
  
  def observe_username
    name = (params[:username].strip).blank? ? nil : User.find_by_username(params[:username].strip)    
    render :json => (name ? true : false).to_json
  end
  
  def update_username
    updated = false
    updated = current_user.update_attribute(:username, params[:username].strip) unless params[:username].blank?
    session.delete(:fb_user_signup)
    session.delete(:fb_user_name)
    render :json => updated.to_json
  end  
end
