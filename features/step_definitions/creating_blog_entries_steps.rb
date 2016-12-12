require 'faker'

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
    @title = Faker::App.name
    page.title = @title

    @author = Faker::Name.name
    page.author = @author

    @entry = Faker::Lorem.paragraph
    page.entry = @entry

    page.create
  end
end

Then(/^I am notified that the blog post was successfully added$/) do
  on_page BlogPost do |page|
    expect(page.title).to eq @title
    expect(page.author).to eq @author
    expect(page.text).to eq @entry

    @dateCreated = page.date_created
    puts @dateCreated
  end
end

And(/^the newly added blog post is at the top of the recent posts list$/) do
  visit_page BlogHome do |page|
    expect(page.blog_list_title_at(FIRST)).to eq @title
    expect(page.blog_list_date_at(FIRST)).to eq @dateCreated
  end
end
