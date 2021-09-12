class Users::SessionsController < Devise::SessionsController
    respond_to :json

    # def new
    #   super
    
    # end


    # def create
    #   # puts self.resource
    #   # self.resource = warden.authenticate!(auth_options)
    #   # sign_in(resource_name, resource)
    #   puts "IN CREATEEEEE"
    #   sign_in(resource_name, resource)
    #   # yield resource if block_given?
    #   respond_with resource, location: after_sign_in_path_for(resource)

    # end
  
    private

    # def auth_options
    #   puts "in auth options"
    #   # { scope: resource_name, recall: "#{controller_path}#new" }
    # end
  
    def respond_with(resource, _opts = {})
      puts "RESPONDING"
      puts _opts
      render json: resource
    end
  
    def respond_to_on_destroy
      log_out_success && return if current_user
  
      log_out_failure
    end
  
    def log_out_success
        # token = request.headers['Authorization']
        # puts user
      render json: { message: "You are logged out." }, status: :ok
    end
  
    def log_out_failure
      render json: { message: "Hmm nothing happened."}, status: :unauthorized
    end
  end