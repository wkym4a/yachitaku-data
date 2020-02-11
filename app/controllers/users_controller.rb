class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  def show
  end

  # def edit
  #
  # end
  #
  # def update
  #   if @user.update(user_params_for_update)
  #     redirect_to @user, notice: 'ユーザー情報を変更しました。'
  #   else
  #
  #     #エラー情報をフラッシュに保存
  #     flash[:danger] = @user.errors.full_messages
  #     render :edit
  #   end
  # end

  private
    def set_user
      @user = User.find(params[:id])
    end
  
  #   def user_params_for_update
  #     params_info = params.require(:user).permit(:account_name, :email_public_div, :profile, :public_div, :pin_public_div_default,
  #         workboxes_attributes: [:id, :workbox_name, :default_box, :_destroy],
  #         plans_attributes: [:id, :plan_name, :default_plan, :_destroy])
  #
  #   return  params_info
  #   end

end
