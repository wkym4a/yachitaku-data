class BuildingsController < ApplicationController
  #ログインしているかどうかをチェック
  before_action :authenticate_user!

  before_action :set_building, only: [:show, :edit, :update, :destroy]

  def index
    # @q = Building.ransack(params[:q])
    # @buildings = @q.result(distinct: true)
    @buildings = Building.all
  end
  def index_search
    @buildings = Building.
                search_by_name(params[:conditions][:name]).
                search_by_ooya_surname(params[:conditions][:ooya_surname]).
                search_by_ooya_name(params[:conditions][:ooya_name])
    # @buildings = Building.left_joins(:ooya).where(ooyas: {name: ["4"]})
    respond_to do |format|
        format.js { render :index_box }
    end
  end

  def show
  end

  def new
    # 「大家」のshow画面から遷移した場合は、その大家を初期設定とする。
    @building = Building.new(ooya_id: params[:ooya_id])
  end

  def edit
  end

  def create
    @building = Building.new(building_params)

    if @building.save
      redirect_to @building, notice: '建物情報を作成しました。'
    else
      flash[:danger] = @building.errors.full_messages
      render :new
    end
  end

  def update
    if @building.update(building_params)
      redirect_to @building, notice: '建物情報を更新しました。'
    else
      flash[:danger] = @building.errors.full_messages
      render :edit
    end
  end

  def destroy
    @building.destroy
    redirect_to buildings_url, notice: '建物情報を削除しました。'
  end

  private
    def set_building
      @building = Building.find(params[:id])
    end

    def building_params
      params.require(:building).permit(:name, :sekisui_div, :sekisui_num, :type_div, :zip_cd, :address ,:lat, :lon, :floor, :memo, :ooya_id)
    end
end
