# frozen_string_literal: true

module RequestSpecHelpers
  def login(email, password)
    post login_path, params: { login: { email: email, password: password } }
  end

  def logout(id)
    delete logout_path, params: { user_id: id }
  end
end
