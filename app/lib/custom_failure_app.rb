class CustomFailureApp < Devise::FailureApp
  def redirect_url
    # This CustomFailureApp class extends Devise::FailureApp and overrides the redirect_url method
    # to specify the URL where the user should be redirected after a failed sign-in.
    # Customize the redirection URL after a failed sign-in
    new_user_session_url
  end
end