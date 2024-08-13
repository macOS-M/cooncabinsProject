class CabinsController < ApplicationController
  before_action :set_cabin, only: %i[show edit update destroy]
  before_action :authorize_admin!, only: %i[edit update destroy]

  # GET /cabins or /cabins.json
  def index
    @cabins = Cabin.all
  end

  # GET /cabins/1 or /cabins/1.json
  def show
    @cabin = Cabin.find(params[:id])
    @review = Review.new
  end


  # GET /cabins/new
  def new
    @cabin = Cabin.new
  end

  # GET /cabins/1/edit
  def edit
  end

  # POST /cabins or /cabins.json
  def create
    @cabin = Cabin.new(cabin_params)

    respond_to do |format|
      if @cabin.save
        format.html { redirect_to cabin_url(@cabin), notice: "Cabin was successfully created." }
        format.json { render :show, status: :created, location: @cabin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cabin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cabins/1 or /cabins/1.json
  def update
    respond_to do |format|
      if @cabin.update(cabin_params)
        format.html { redirect_to cabin_url(@cabin), notice: "Cabin was successfully updated." }
        format.json { render :show, status: :ok, location: @cabin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cabin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cabins/1 or /cabins/1.json
  def destroy
    @cabin.destroy!

    respond_to do |format|
      format.html { redirect_to cabins_url, notice: "Cabin was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  def create_review
    @cabin = Cabin.find_by(id: params[:id])
    
    if @cabin.nil?
      flash[:alert] = "Cabin not found."
      redirect_to cabins_path
      return
    end

    @review = @cabin.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to @cabin, notice: "Review submitted successfully."
    else
      flash.now[:alert] = "There was a problem submitting your review."
      render :show
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cabin
      @cabin = Cabin.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cabin_params
      params.require(:cabin).permit(:name, :description, :price, :image)
    end
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
    def authorize_admin!
      unless current_user.admin?
        flash[:alert] = "You are not authorized to perform this action."
        redirect_to cabins_path
      end
    end
end

