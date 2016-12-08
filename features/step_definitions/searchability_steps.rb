require 'page-object'
require 'byebug'

include PageObject::PageFactory


Then(/^the url should contain information about the post$/) do
  on_page BlogPost do |page|
    @url = String(@browser.url)
    @split_title = page.title.split('/\w+/')
    expect(@split_title).to include (page.title)
    expect(@url).to include (String(page.date_created.year))
    expect(@url).to include (String(page.date_created.month))
    expect(@url).to include (String(page.date_created.day))
  end
end