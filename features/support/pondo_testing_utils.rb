module PondoTestingUtils
  def jscript(code)
    page.evaluate_script(code)
  end

  def pondo_page(name)
    PondoSpecs::Pages.send("#{ name }_page")
  end

  def pondo_page_content(name)
    PondoSpecs::Pages.send("#{ name }_page_content")
  end

  def safe_date_fill_in(finder, date)
    field = find_field(finder)
    date_formatted = date.strftime("%Y-%m-%d")
    jscript("document.evaluate('#{field.path}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.value='#{date_formatted}'")
  end
end

World(PondoTestingUtils)
World(ActiveJob::TestHelper)
