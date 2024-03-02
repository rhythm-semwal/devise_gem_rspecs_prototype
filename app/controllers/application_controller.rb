class ApplicationController < ActionController::Base
  before_action :log_request_details
  skip_before_action :verify_authenticity_token, only: [:new]

  def log_request_details
    puts "Request Method: #{request.method}, Path: #{request.path}"
  end
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
