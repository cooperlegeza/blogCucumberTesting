require 'page-object'
require 'watir-webdriver'

class BlogSearchResults
  include PageObject

  links(:blog_titles, :class => 'search-result-title')

  def all_blog_titles
    all_blogs = []
    blog_titles_elements.each_with_index do |title, index|
      all_blogs[index] = title.text
    end
    all_blogs
  end

end