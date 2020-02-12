class OoyasController < ApplicationController
  #ログインしているかどうかをチェック
  before_action :authenticate_user!

  before_action :set_ooya, only: [:show, :edit, :update, :destroy]

  def index
    @ooyas = Ooya.all
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
      redirect_to @ooya, notice: 'Ooya was successfully created.'
    else
      render :new
    end
  end

  def update
    if @ooya.update(ooya_params)
      redirect_to @ooya, notice: 'Ooya was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ooyas/1
  # DELETE /ooyas/1.json
  def destroy
    @ooya.destroy
    redirect_to ooyas_path, notice: 'Ooya was successfully destroyed.'
  end

  private
    def set_ooya
      @ooya = Ooya.find(params[:id])
    end

    def ooya_params
      params.require(:ooya).permit(:surname, :name, :surname_kana, :name_kana, :zip_cd, :address1, :address2, :tel, :mobile, :memo,buildings_attributes: [:id, :name, :sekisui_div,:type_div, :_destroy])
    end
end
