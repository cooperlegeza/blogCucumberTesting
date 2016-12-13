require 'faker'

Then(/^I should see comments left by other readers$/) do
  on_page BlogPost do |page|
    author = Faker::Name.name
    page.comment_author = author

    comment_text = Faker::Lorem.paragraph
    page.comment_text = comment_text
    date_created = DateTime.now.strftime(DATETIME_PATTERN)

    page.create_comment
    sleep 1
    expect(page.first_comment_author).to eq(author)
    expect(page.first_comment_text).to eq(comment_text)
    expect(page.first_comment_date_created).to eq(date_created)
  end
end

Given(/^I am reading a blog post from my favorite blogger$/) do
  visit_page BlogHome do |page|
    page.first_blog
  end
end


When(/^I add my genius comment to the blog post$/) do
  on_page BlogPost do |page|
    @author = Faker::Name.name
    page.comment_author = @author

    @comment_text = Faker::Lorem.paragraph
    page.comment_text = @comment_text
    @date_created = DateTime.now.strftime(DATETIME_PATTERN)
    page.create_comment
  end
end

Then(/^my genius comment is at the top of the blog post comments$/) do
  on_page BlogPost do |page|
    sleep 1
    expect(page.first_comment_author).to eq @author
    expect(page.first_comment_text).to eq @comment_text
    expect(page.first_comment_date_created).to eq @date_created
  end
end