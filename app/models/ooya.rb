class Ooya < ApplicationRecord
  has_many :buildings , dependent: :nullify
  accepts_nested_attributes_for :buildings, allow_destroy: true

  ####↓↓↓↓バリデーション情報↓↓↓↓############
  validates :surname, presence: true, length: { maximum: 20 }
  validates :name, presence: true, length: { maximum: 20 }
  validates :surname_kana, length: { maximum: 40 }
  validates :name_kana, length: { maximum: 40 }
  validates :zip_cd, length: { maximum: 7 }
  validates :address1, length: { maximum: 120 }
  validates :address2, length: { maximum: 120 }
  validates :tel, length: { maximum: 20 }
  validates :mobile, length: { maximum: 20 }
  validates :memo, length: { maximum: 800 }
  ####↑↑↑↑バリデーション情報↑↑↑↑############

  def full_name
    "#{self.surname} #{self.name}"
  end
  def full_name_kana
    "#{self.surname_kana} #{self.name_kana}"
  end
  def zip_cd_show
    "〒#{self.zip_cd[0,3]}-#{self.zip_cd[3,4]}"
  end

  def full_address
    if self.zip_cd.length == 7
      "#{self.zip_cd_show} #{self.address1} #{self.address2}"
    else
      "#{self.address1} #{self.address2}"
    end
  end

end
