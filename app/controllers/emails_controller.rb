class EmailsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create]

  def create
    @email = Email.find_or_create_by(email_params)
    return redirect_to "/" unless @email.valid?

    session[:email] ||= []
    session[:email] << @email.email
    return redirect_to "/" if @email.persisted?

    respond_to do |format|
      format.html { redirect_to "/" }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:email)
    end
end
