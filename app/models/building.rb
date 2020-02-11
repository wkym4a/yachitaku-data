class Building < ApplicationRecord
  belongs_to :ooya

  enum sekisui_div:{
    general: 0, #一般
    sekisui: 1 #積水
  }

  enum type_div:{
    apartment: 0, #アパート
    mansion: 1, #マンション
    house: 2, #戸建て
    rental_store: 9, #貸店舗
    parking: 99 #駐車場
  }
end
