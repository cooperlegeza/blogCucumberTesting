require 'page-object'

include PageObject::PageFactory

BLOG_SEARCH_VALUE = 'hello'

Given(/^my favorite blogger has been very active$/) do
  visit_page BlogHome do |page|
  end

  on_page BlogHome do |page|
    page.login
  end

  on_page LoginPage do |page|
    page.username = BLOGGER_NAME
    page.password = BLOGGER_PASSWORD
    page.submit_button
  end

  for count in 0..10 do
    on_page BlogHome do |page|
      page.create_post
    end

    on_page CreatePost do |page|
      page.title = BLOG_TITLE
      page.author = BLOG_AUTHOR
      page.entry = BLOG_ENTRY
      page.create
    end
  end
end

When(/^I visit the blog for my favorite blogger$/) do
  visit_page BlogHome do |page|

  end
end

Then(/^then I should see a summary of my favorite blogger's (\d+) most recent posts in reverse order$/) do |arg1|
  on_page BlogHome do |page|
    number_of_blogs = 0
    page.blog_posts_recent_elements.each_with_index do |post, index|
      count = 0
      number_of_blogs = number_of_blogs + 1
      expect(number_of_blogs).to be <= Integer(arg1)

      expect(page.blog_posts_recent_title_at(index)).to eq page.blog_list_title_at(index)
      expect(page.blog_posts_recent_date_at(index)).to eq page.blog_list_date_at(index)
    end

    datetime_count = 1
    for datetime in 0..(page.most_recent_blogs_date_created_elements.size - 1)
      for datetime_to_be_compared in datetime_count..(page.most_recent_blogs_date_created_elements.size - 1)
        expect(page.blog_posts_recent_date_at(datetime_to_be_compared)).to be < page.blog_posts_recent_date_at(datetime)
      end
      datetime_count = datetime_count + 1
    end
  end
end

When(/^I choose a blog post$/) do
    on_page BlogHome do |page|
    @blog_title = page.blog_list_title_at(FIRST)
    @blog_author = page.blog_list_author_at(FIRST)
    @blog_text = page.blog_list_text_at(FIRST)
    @blog_date = page.blog_list_date_at(FIRST)
    page.first_blog_link
  end
end

Then(/^I should see the blog post$/) do
  on_page BlogPost do |page|
    expect(page.title).to eq @blog_title
    expect(page.author).to eq @blog_author
    expect(page.text).to eq @blog_text
    expect(page.date_created).to eq @blog_date
  end
end

When(/^I search for a blog post$/) do
  on_page BlogHome do |page|
    page.search_field = BLOG_SEARCH_VALUE
    page.submit_search
  end
end

Then(/^I should see posts with that value in the title$/) do
  on_page BlogSearchResults do |page|
    page.all_blog_titles.each do |title|
      expect(title.downcase).to include BLOG_SEARCH_VALUE
    end
  end
end