class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authorize_company!
    unless current_user.admin?
      company_id = params[:company_id]
      if company_id.present? && (current_user.company_id != company_id.to_i)
        redirect_to root_path
        flash[:error] = "You do not have permission to view page"
      end
    end
  end
  
  def authorize_manager!
    unless current_user.admin? || current_user.manager?
<<<<<<< .merge_file_gdhDQy
      redirect_to root_path
      flash[:error] = "You do not have permission to view page"
    end
  end
  
end
=======
        redirect_to root_path
        flash[:error] = "You do not have permission to view page"
    end
  end
       
end
>>>>>>> .merge_file_E8l3uy
