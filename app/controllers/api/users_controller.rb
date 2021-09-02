class Api::UsersController < Api::BaseController
    before_action :authenticate_user!
    
    def index
        @users = User.all
        data = {
            users: @users
        }
        render json: data.to_json()
        # render jsonapi: @users
        # render_jsonapi_response(@users)
    end

    def show
        @data = {
            user: current_user,
            message: 'this is the current user'
        }
        render json: @data.to_json()
    end
  
    # private
  
    # def find_user
    #   @user = User.find(params[:id])
    # end
  
end
  