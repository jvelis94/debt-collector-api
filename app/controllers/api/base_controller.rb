class Api::BaseController < ApplicationController

    before_action :authenticate_user!
  
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
    def not_found
      render json: {
        'errors': [
          {
            'status': '404',
            'message': 'Not Found'
          }
        ]
      }, status: 404
    end
  
end