class CustomFailureApp < Devise::FailureApp
  # def redirect_url
  #   # This CustomFailureApp class extends Devise::FailureApp and overrides the redirect_url method
  #   # to specify the URL where the user should be redirected after a failed sign-in.
  #   # Customize the redirection URL after a failed sign-in
  #   new_user_session_url
  # end

  def respond
    if request.format == :json
      json_error_response
    else
      super
    end
  end

  def json_error_response
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { error: 'Invalid email or password' }.to_json
  end
end