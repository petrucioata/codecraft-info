module RequestSpecHelpers
  
  def login(email, password)
    post login_path, params: {login: {email: email, password: password}}
  end

  def logout(id)
    delete logout_path, user_id: id
  end

end