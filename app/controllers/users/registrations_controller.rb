class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
    build_rsvps
    super
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  def edit
    build_rsvps
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << override_params
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << override_params
  end

  private

  def override_params
    [:first_name, :last_name, :dietary_restriction, :hotel_rooms, :special_instructions, :role, :reminders, :invite_code, :rsvps_attributes => [:id, :going, :rsvp_type]]
  end

  def build_rsvps(id = @user.try(:id))
    Rsvp::TYPES.each do |rsvp|
      next if id.present? && Rsvp.where(rsvper_id: id, rsvp_type: rsvp, rsvper_type: 'User').present?
      @user.rsvps.build(rsvp_type: rsvp)
    end
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
