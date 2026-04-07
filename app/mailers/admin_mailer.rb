class AdminMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def new_user(user)
    @user = user

    mail(
      to: "chandn33@example.com",
      subject: "New user registered: #{@user.email}"
    )
  end

  def new_book(book)
    @book = book

    mail(
      to: "chandn33@example.com",
      subject: "New book created: #{@book.name}"
    )
  end
end
