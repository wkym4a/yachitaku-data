class Ooya < ApplicationRecord
  require 'rubyXL/convenience_methods'

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

    def self.export_info

      # workbook = RubyXL::Parser.parse file.path
      workbook = RubyXL::Workbook.new

      sheet = workbook[0]

      contents_sheet = workbook.first

      contents_sheet.add_cell(0, 0 , "《大家名称》" )
      contents_sheet.add_cell(0, 1 , "詳細シートへのリンク" )

      row=0
      all.each{|ooya|
        ooya_sheet = workbook.add_worksheet(ooya.full_name.gsub(" ", ""))
        ooya_sheet.add_cell(1, 0 , "大家名称" )
        ooya_sheet.add_cell(1, 1 , ooya.full_name )
        ooya_sheet.add_cell(2, 0 , "住所" )
        ooya_sheet.add_cell(2, 1 , ooya.full_address )
        ooya_sheet.add_cell(3, 0 , "電話" )
        ooya_sheet.add_cell(3, 1 , ooya.tel )
        ooya_sheet.add_cell(4, 0 , "携帯" )
        ooya_sheet.add_cell(4, 1 , ooya.mobile )
        ooya_sheet.add_cell(5, 0 , "備考" )
        ooya_sheet.add_cell(5, 1 , ooya.memo )

        ooya_sheet.add_cell(7, 1 , "所有物件" )
        ooya.buildings.each_with_index do |buildind, i|
          ooya_sheet.add_cell(i + 8, 2 , "●#{buildind.name}" )
        end

        #目次シートから、「今回の大家についてのシート」へリンクを貼る
        row += 1
        contents_sheet.add_cell(row, 0 , ooya.full_name )
        hyperlink = %Q[HYPERLINK("##{ooya.full_name.gsub(" ", "")}!A1","→リンク")]
        contents_sheet.add_cell(row, 1 , '', hyperlink )
      }

      # file_name = "大家情報一覧.xlsx"

return workbook
#       workbook.write(file_name)
#
# send_data workbook.stream.string,  filename: 'modified.xlsx'
      # `open #{file_name} `

    end

end



# def self.export_info
#   @workbook = RubyXL::Workbook.new
#   @sheet = @workbook.first
#
#   row=0
#   @sheet.add_cell(row, 0, "新規登録の場合、「id」欄は空欄としてください。")
#
#   columns = self.column_names
#
#   row += 1
#   columns.each_with_index do |col, i|
#     @sheet.add_cell(row, i , col )
#   end
#
#   all.each{|ooya|
#     row += 1
#
#     columns.each_with_index do |col, i|
#       @sheet.add_cell(row, i , ooya[col] )
#     end
#   }
#
#   file_name = "#{Time.current.strftime('%Y%m%d')}.xlsx"
#   @workbook.write(file_name)
#
#   `open #{file_name} `
#
# end
