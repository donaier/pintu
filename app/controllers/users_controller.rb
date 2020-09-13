class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy, :enable, :update_password, :add_role, :revoke_role]
  before_action :set_qr, only: [:show, :edit]


  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.add_role(:bambi)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: I18n.t('user.create.success') }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:user] && params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update(user_params)
      redirect_to @user, notice: I18n.t('user.update.success')
    else
      render :edit
    end
  end

  def enable
    @user.update_attribute(:otp_required_for_login, true)
    @user.remove_role(:bambi) if @user.has_role? :bambi
    redirect_to edit_user_path @user
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: I18n.t('user.destroy.success')
  end

  def add_role
    @user.add_role params[:role]
    redirect_to edit_user_path @user
  end

  def revoke_role
    @user.remove_role params[:role]
    redirect_to edit_user_path @user
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def set_qr
      qrcode = RQRCode::QRCode.new(@user.otp_provisioning_uri('pintu', issuer: "pintu:#{@user.email}"))

      @qr = qrcode.as_svg(
        offset: 0,
        color: '000',
        shape_rendering: 'crispEdges',
        module_size: 6,
        standalone: true
      )
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username, :otp_required_for_login)
    end
end
