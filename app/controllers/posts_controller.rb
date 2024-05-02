class PostsController < ApplicationController
    before_action :authenticate_request
    def index 
        render json: {
            value: "Data from Rails backend"
        }, status: :ok
    end
end
