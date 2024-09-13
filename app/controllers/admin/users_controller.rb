module Admin
    class UsersController < ApplicationController
       layout 'admin'
      before_action :set_user, only: [:show, :edit, :update, :destroy]
  
      def show
      end
      def index
        per_page = 10
        page = params.fetch(:page, 1).to_i
        @users = User.all
    
        # Sorting
        @users = @users.where(id: params[:id]) if params[:id].present?
        @users = @users.where('email LIKE ?', "%#{params[:email]}%") if params[:email].present?
        @users = @users.where(admin: ActiveModel::Type::Boolean.new.cast(params[:admin])) if params[:admin].present?
    
        
        if params[:sort].present?
          direction = params[:direction] == "desc" ? "desc" : "asc"
          @users = @users.order("#{params[:sort]} #{direction}")
        end
    
        # Pagination
        @total_pages = (@users.count / per_page.to_f).ceil
        @users = @users.offset((page - 1) * per_page).limit(per_page)
      end
      def edit
      end
      def new
        @user = User.new
      end
      def create
        @user = User.new(user_params)
        if @user.save
          redirect_to admin_dashboard_users_path, notice: 'User was successfully created.'
        else
          render :new
        end
      end
  
      def update
        if @user.update(user_params)
          redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
        else
          render :edit
        end
      end
  
      def destroy
        @user.destroy
        redirect_to admin_dashboard_users_path, notice: 'User was successfully deleted.'
      end
  
      private
  
      def set_user
        @user = User.find(params[:id])
      end
  
      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :admin)
      end
    end
  end
  