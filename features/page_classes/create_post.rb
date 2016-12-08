require 'page-object'
require 'watir-webdriver'

class CreatePost
  include PageObject

  text_field(:title, :id => 'titleId')
  text_field(:author, :id => 'authorId')
  text_area(:entry, :id => 'textId')
  element(:submit_form, :id => 'create')

  def create
    @browser.send_keys :tab
    @browser.send_keys :enter
  end

end