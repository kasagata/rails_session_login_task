class ApplicationController < ActionController::Base
    include SessionsHelper
    before_action :login_required

    private

    def login_required
      if current_user = nil
        redirect_to new_session_path
        flash[:notice] = 'ログインしてください'
      end
    end

end
