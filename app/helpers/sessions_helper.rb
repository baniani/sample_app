module SessionsHelper
	def sign_in(user)
    	remember_token = User.new_remember_token
    	cookies.permanent[:remember_token] = remember_token
    	user.update_attribute(:remember_token, User.encrypt(remember_token))
    	self.current_user = user
  	end

  	def signed_in?
    	!current_user.nil?
  	end

  	#implementing the property in C# the only thing is that since we are going to diffrent pages
  	#every new page @current_user becomes nil so that is why we use the getter to search the db based on the token to find 
  	#the user and ssign it

  	def current_user=(user)
    	@current_user = user
  	end

  	def current_user
    	remember_token = User.encrypt(cookies[:remember_token])
    	@current_user ||= User.find_by(remember_token: remember_token)
  	end

  	def sign_out
    	self.current_user = nil
    	cookies.delete(:remember_token)
  	end
end
