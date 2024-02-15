class UsersController < ApplicationController
    before_action :correct_user, only: [:show]
    skip_before_action :login_required, only: [:new, :create]
    
    def new
      @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
          session[:user_id] = @user.id
          redirect_to tasks_path(@user.id), notice: 'アカウントを登録しました'
        else
          render :new
        end
      end

    def show
      @user = User.find(params[:id])
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
          redirect_to user_path, notice: 'アカウントを更新しました。'
      else
          render :edit
      end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
        format.html { redirect_to user_path, notice: "削除しました。" }
        end
    end
    
      private
    
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

      def correct_user
        @user = User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
      end
  end