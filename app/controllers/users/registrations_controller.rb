class Users::RegistrationsController < Devise::RegistrationsController
before_filter :authenticate_user!, :only => :token
before_filter :loading,:only=>[:edit,:update,:edit_password,:update_password]
  def new
      @user=User.new
      @profile=@user.create_profile
  end

 
  def create
	profile1=[:profile]
	user1=params[:user].slice!(*profile1)
    @user = User.new(user1)
    if @user.save
      @profile=Profile.new(params[:user][:profile])
      @profile.user_id=@user.id
      @profile.save
      flash[:notice] = "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."
      redirect_to root_url
    else
      clean_up_passwords(resource)
      redirect_to new_registration_path(resource) 
    end
  end

  def edit
    super
  end
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
      
      profile1=[:profile]
		  user1=params[:user].slice!(*profile1)
		  current_user.username=user1['username']
		  current_user.update_attributes(:username=>current_user.username)
		  if current_user.update_attributes(params[:user].slice!(*profile1))
		   if current_user.profile.update_attributes(params[:user][:profile])
	       profile=current_user.profile.id
	       redirect_to after_update_path_for(profile)
	     else
	       redirect_to edit_user_registration_path
		   end
		  else
        redirect_to edit_user_registration_path
		  end
  end
 
 def edit_password
  @user=current_user
 end
 
 def update_password
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)

    if resource.update_with_password(params[resource_name])
      set_flash_message :notice, :updated if is_navigational_format?
      sign_in resource_name, resource, :bypass => true
      redirect_to root_path
    else
      clean_up_passwords(resource)
      respond_with_navigational(resource){ render :edit_password }
    end
 end
 
 protected

    def after_update_path_for(profile)
      profile_path(profile)
    end
   def loading
     if user_signed_in?
       
     else
       redirect_to new_user_session_path
     end  
   end
end
