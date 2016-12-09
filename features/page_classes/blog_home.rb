require 'page-object'
require 'watir-webdriver'

class BlogHome
  include PageObject
  page_url 'http://localhost:8080'

  links(:blog_post, :class => 'blog-post-title')
  spans(:date_created, :class => 'date-created')
  link(:login, :class => 'login-button')
  link(:create_post, :class => 'create')
  links(:blog_posts_recent, :class => 'most-recent-blog')
  spans(:most_recent_blogs_date_created, :class => 'most-recent-date-created')
  link(:first_blog, :class => 'blog-post-title')
  spans(:blog_post_authors, :class => 'blog-front-page-author')
  spans(:blog_post_contents, :class => 'blog-front-page-post')
  text_field(:search_field, :id => 'searchText')
  button(:submit_search, :id => 'search-submit')

  def blog_posts_recent_title_at(index)
    blog_posts_recent_elements[index].text
  end


  def blog_posts_recent_date_at(index)
    DateTime.parse(most_recent_blogs_date_created_elements[index].attribute('title'))
  end

  def blog_list_title_at(index)
    blog_post_elements[index].text
  end

  def blog_list_date_at(index)
    DateTime.parse(date_created_elements[index].text)
  end

  def blog_list_author_at(index)
    blog_post_authors_elements[index].text
  end

  def blog_list_text_at(index)
    blog_post_contents_elements[index].text
  end

  def blog_date_created_list

  end

  def search
    @browser.send_keys :tab
    @browser.send_keys :enter
  end
end
