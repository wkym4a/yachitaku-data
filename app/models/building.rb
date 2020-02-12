class Building < ApplicationRecord
  belongs_to :ooya

  ####↓↓↓↓バリデーション情報↓↓↓↓############
  validates :name, length: { maximum: 20 }
  validates :sekisui_num, length: { maximum: 7 }
  validates :zip_cd, length: { maximum: 7 }
  validates :address, length: { maximum: 200 }
  validates :memo, length: { maximum: 800 }
  ####↑↑↑↑バリデーション情報↑↑↑↑############

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


  def zip_cd_show
    "〒#{self.zip_cd[0,3]}-#{self.zip_cd[3,4]}"
  end
  def full_address
    if self.zip_cd.length == 7
      "#{self.zip_cd_show} #{self.address}"
    else
      "#{self.address}"
    end
  end
  def sekisui_num_info
    if self.sekisui_div_i18n == "積水"
      self.sekisui_num
    else
      "一般物件"
    end
  end

end
