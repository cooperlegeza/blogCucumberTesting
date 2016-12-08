COMMENT_AUTHOR = 'Cooper'
COMMENT_TEXT = 'This is a comment!'
DATETIME_PATTERN = '%Y%m%d%T'

Then(/^I should see comments left by other readers$/) do
  on_page BlogPost do |page|
    page.comment_author = COMMENT_AUTHOR
    page.comment_text = COMMENT_TEXT
    @date_created = DateTime.now.strftime(DATETIME_PATTERN)
    page.create_comment

    expect(page.first_comment_author).to eq(COMMENT_AUTHOR)
    expect(page.first_comment_text).to eq(COMMENT_TEXT)
    expect(page.first_comment_date_created).to eq(@date_created)
  end
end

Given(/^I am reading a blog post from my favorite blogger$/) do
  visit_page BlogHome do |page|
    page.first_blog_link
  end
end


When(/^I add my genius comment to the blog post$/) do
  on_page BlogPost do |page|
    page.comment_author = COMMENT_AUTHOR
    page.comment_text = COMMENT_TEXT
    @date_created = DateTime.now.strftime(DATETIME_PATTERN)
    page.create_comment
  end
end

Then(/^my genius comment is at the top of the blog post comments$/) do
  on_page BlogPost do |page|
    expect(page.first_comment_author).to eq COMMENT_AUTHOR
    expect(page.first_comment_text).to eq COMMENT_TEXT
    expect(page.first_comment_date_created).to eq @date_created
  end
end