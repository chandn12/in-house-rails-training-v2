class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def index
    @pagy, @users = pagy(User.all)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.password.blank?
      @user.password = SecureRandom.hex(10)
      @user.password_confirmation = @user.password
    end

    if @user.save
      redirect_to admin_user_path(@user), notice: "User successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User successfully updated."
    else
      render :edit
    end
  end



  def destroy
    @user = User.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :date_of_birth)
  end

  def require_admin!
    redirect_to root_path unless current_user&.admin?
  end
end
