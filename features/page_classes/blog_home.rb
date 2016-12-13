require 'page-object'
require 'watir-webdriver'

class BlogHome
  include PageObject
  page_url 'http://localhost:8080'

  links(:blog_post, :class => 'blog-post-title')
  spans(:date_created, :class => 'date-created')
  link(:login, :class => 'login-button')
  link(:create_post, :class => 'createNewPost')
  link(:first_blog, :class => 'blog-post-title')
  spans(:blog_post_authors, :class => 'blog-front-page-author')
  spans(:blog_post_contents, :class => 'blog-front-page-post')
  text_field(:search_field, :id => 'searchText')
  button(:submit_search, :id => 'search-submit')

  def recent_blog_titles
    all_titles = []
    blog_post_elements.each do |title|
      all_titles << title.text
    end
    all_titles
  end

  def recent_blog_authors
    all_authors = []
    blog_post_authors_elements.each do |author|
      all_authors << author.text
    end
    all_authors
  end

  def recent_blog_entries
    all_entries = []
    blog_post_contents_elements.each do |entry|
      all_entries << entry.text
    end
    all_entries
  end

  def recent_blog_dates
    all_dates = []
    date_created_elements.each do |date|
      all_dates << DateTime.parse(date.text)
    end

    all_dates
  end


  def blog_list_title_at(index)
    blog_post_elements[index].text
  end

  def blog_list_author_at(index)
    blog_post_authors_elements[index].text
  end

  def blog_list_contents_at(index)
    blog_post_contents_elements[index].text
  end

  def blog_list_date_at(index)
    DateTime.parse(date_created_elements[index].text)
  end

  def search
    @browser.send_keys :tab
    @browser.send_keys :enter
  end
end
