class EmailsController < ApplicationController
  skip_before_action :authorized, only: [:index, :create]

  def create
    @email = Email.find_or_initialize_by(email_params)
    return redirect_to "/" if @email.persisted?

    session[:email] ||= []
    respond_to do |format|
      if @email.save
        session[:email] << @email.email
        format.html { redirect_to "/" }
      else
        format.html { render :index }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:email)
    end
end
