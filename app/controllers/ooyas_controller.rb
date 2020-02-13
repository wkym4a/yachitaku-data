class OoyasController < ApplicationController
  #ログインしているかどうかをチェック
  before_action :authenticate_user!

  before_action :set_ooya, only: [:show, :edit, :update, :destroy]

  def index
    @q = Ooya.ransack(params[:q])
    @ooyas = @q.result(distinct: true)
    # @ooyas = Ooya.all
  end

  def show
    @buildings = @ooya.buildings
  end

  def new
    @ooya = Ooya.new
  end

  def edit
  end

  def create
    @ooya = Ooya.new(ooya_params)

    if @ooya.save
      redirect_to @ooya, notice: 'オーナー情報を作成しました。'
    else
      flash[:danger] = @ooya.errors.full_messages
      render :new
    end
  end

  def update
    if @ooya.update(ooya_params)
      redirect_to @ooya, notice: 'オーナー情報を更新しました。'
    else
      flash[:danger] = @ooya.errors.full_messages
      render :edit
    end
  end

  # DELETE /ooyas/1
  # DELETE /ooyas/1.json
  def destroy
    @ooya.destroy
    redirect_to ooyas_path, notice: 'オーナー情報を削除しました。'
  end

  private
    def set_ooya
      @ooya = Ooya.find(params[:id])
    end

    def ooya_params
      params.require(:ooya).permit(:surname, :name, :surname_kana, :name_kana, :zip_cd, :address1, :address2, :tel, :mobile, :memo,buildings_attributes: [:id, :name, :sekisui_div,:type_div, :_destroy])
    end
end
