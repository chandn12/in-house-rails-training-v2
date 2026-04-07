require "rubyXL"
require "rubyXL/convenience_methods"

class UserSpreadsheetExport
  def initialize(user)
    @user = user
  end

  def call
    workbook = RubyXL::Parser.parse(Rails.root.join("app/assets/templates/xlsx/user_spreadsheet_template.xlsx"))

    worksheet = workbook[0]
    worksheet.add_cell(0, 0, "Users")
    idx = 4

    User.all.each do |user|
      worksheet.add_cell(idx, 0, user.first_name)
      worksheet.add_cell(idx, 1, user.last_name)
      worksheet.add_cell(idx, 2, user.date_of_birth&.strftime("%Y-%m-%d"))
      worksheet.add_cell(idx, 3, user.email)

      idx = idx + 1
    end
    workbook
  end
end
