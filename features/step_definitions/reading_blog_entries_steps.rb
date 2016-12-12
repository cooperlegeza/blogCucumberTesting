require 'faker'
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

  @blog_titles = []
  @blog_authors = []
  @blog_entries = []

  create_posts

  @blog_titles.reverse!
  @blog_authors.reverse!
  @blog_entries.reverse!
end

When(/^I visit the blog for my favorite blogger$/) do
  visit_page BlogHome do |page|

  end
end

Then(/^then I should see a summary of my favorite blogger's (\d+) most recent posts in reverse order$/) do |arg1|
  on_page BlogHome do |page|
    number_of_blogs = 0
    dates_created = page.recent_blog_dates

    expect(@blog_titles).to match_array(page.recent_blog_titles)
    expect(@blog_authors).to match_array(page.recent_blog_authors)
    expect(@blog_entries).to match_array(page.recent_blog_entries)

    for datetime in 0..(dates_created.size - 2)
        expect(dates_created[datetime + 1]).to be < dates_created[datetime]
    end
  end
end

When(/^I choose a blog post$/) do
    on_page BlogHome do |page|
    @blog_title = page.blog_list_title_at(FIRST)
    @blog_author = page.blog_list_author_at(FIRST)
    @blog_text = page.blog_list_contents_at(FIRST)
    @blog_date = page.blog_list_date_at(FIRST)
    page.first_blog
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

def create_posts
  for count in 0..9 do
    on_page BlogHome do |page|
      page.create_post
    end

    on_page CreatePost do |page|
      title = Faker::App.name
      @blog_titles << title
      page.title = title

      author = Faker::Name.name
      @blog_authors << author
      page.author = author

      entry = Faker::Lorem.paragraph
      @blog_entries << entry
      page.entry = entry

      page.create
    end
  end
end