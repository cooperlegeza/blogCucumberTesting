require 'page-object'

include PageObject::PageFactory

BLOGGER_NAME = 'me'
BLOGGER_PASSWORD = 'password'
BLOG_TITLE = 'Hello!'
BLOG_AUTHOR = 'Cooper'
BLOG_ENTRY = 'I am a blog post! I would enjoy it if you read me!'
FIRST = 0

Given(/^I am logged in as a blogger$/) do
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
end

When(/^I publish a new blog post$/) do
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

Then(/^I am notified that the blog post was successfully added$/) do
  on_page BlogPost do |page|
    expect(page.title).to eq BLOG_TITLE
    expect(page.author).to eq BLOG_AUTHOR
    expect(page.text).to eq BLOG_ENTRY

    @dateCreated = page.date_created
    puts @dateCreated
  end
end

And(/^the newly added blog post is at the top of the recent posts list$/) do
  visit_page BlogHome do |page|
    expect(page.blog_list_title_at(FIRST)).to eq BLOG_TITLE
    expect(page.blog_list_date_at(FIRST)).to eq @dateCreated
  end
end
