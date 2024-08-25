# app/controllers/reviews_controller.rb

class ReviewsController < ApplicationController
    before_action :set_cabin

    before_action :set_review, only: [:destroy]
    before_action :authorize_user!, only: [:destroy]
  
    def create
      @review = @cabin.reviews.build(review_params)
      @review.user = current_user
  
      if @review.save
        redirect_to @cabin, notice: 'Review was successfully created.'
      else
        redirect_to @cabin, alert: 'Failed to create review.'
      end
    end
  
    def destroy
      @review = @cabin.reviews.find(params[:id])
      @review.destroy
      redirect_to @cabin, notice: 'Review was successfully deleted.'
    end
  
    private
  
    def set_cabin
      @cabin = Cabin.find(params[:cabin_id])
    end
  
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    def authorize_user!
      unless @review.user == current_user || current_user.admin?
        flash[:alert] = "You are not authorized to delete this review."
        redirect_to @review.cabin
      end
  end
end
  