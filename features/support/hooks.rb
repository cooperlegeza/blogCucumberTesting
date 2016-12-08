Before do
  @browser = Watir::Browser.new :chrome
end
After do
  sleep 2
  @browser.close
end
