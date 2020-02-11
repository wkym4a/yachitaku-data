class Ooya < ApplicationRecord
  has_many :buildings , dependent: :nullify
  accepts_nested_attributes_for :buildings, allow_destroy: true 

  def full_name
    "#{self.surname} #{self.name}"
  end
  def full_name_kana
    "#{self.surname_kana} #{self.name_kana}"
  end
  def zip_cd_show
    "〒#{self.zip_cd[0,3]}-#{self.zip_cd[3,4]}"
  end

end
