class UsersController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
   active_scaffold do |c|
	
  end

  # render new.rhtml
  def new
    @user = User.new
	@person = Person.find(:all,:joins=> "LEFT JOIN users ON users.person_id = people.id",:conditions => "users.person_id IS NULL")
  end
 
  def create
    logout_keeping_session!
	#@person = Person.find(params[:user][:person_id])
	@person_id = params[:user][:person_id]
	params[:user].delete(:person_id)
    @user = User.new(params[:user])
	#logger.debug "params[:user]: #{params[:user]}"
	#@user.person << @person#@person.user << @user
	@user.person_id = 	@person_id 
    success = @user && @user.save
	
    if success && @user.errors.empty?
		
		
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
end
