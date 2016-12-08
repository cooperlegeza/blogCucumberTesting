require 'page-object'
require 'watir-webdriver'

class LoginPage
  include PageObject

  text_field(:username, :id => 'username')
  text_field(:password, :id => 'password')
  button(:submit_button, :id => 'login-submit')

end