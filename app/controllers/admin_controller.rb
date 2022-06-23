class AdminController <ApplicationController
  before_filter :check_for_admin
  def check_for_admin
    if current_user.nil? || !current_user.is_admin?
      redirect_to root_path,alert:  "You need to be admin to use this path."
    end
  end
end