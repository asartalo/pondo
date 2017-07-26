module PondoTestingUtils
  def jscript(code)
    page.evaluate_script(code)
  end

  def expect_script(code, filter = nil)
    result = jscript(code)
    if filter
      result = result.send(filter)
    end
    expect(result)
  end

  def pondo_page(name)
    PondoSpecs::Pages.send("#{ name }_page")
  end

  def pondo_page_content(name)
    PondoSpecs::Pages.send("#{ name }_page_content")
  end

  def expect_nitro_page_fetched(name)
    expect_nitro_page(name, 'isPageFetched')
  end

  def expect_nitro_page_loaded(name)
    expect_nitro_page(name, 'isPageNormallyLoaded')
  end

  def expect_nitro_page_restored(name)
    expect_nitro_page(name, 'isPageCacheRestored')
  end

  def expect_page_content_to_be_loaded(name)
    expect(page).to have_text(pondo_page_content(name) || "")
  end

  def expect_no_js_errors
    expect_script("pondoTesting.hasJavascriptErrors()").to eql(false)
  end

  def expect_nitro_load_count
    expect_script("pondoTesting.loadCount", :to_i)
  end

  def safe_date_fill_in(finder, date)
    field = find_field(finder)
    # Test out all possible formats and see what works
    [
      "%m/%d/%Y",
      "%d/%m/%Y",
      "%Y/%m/%d"
    ].each do |format|
      fill_in finder, with: date.strftime(format)
      field.native.send_keys :tab # Force blur
      break if field.value == date.strftime("%Y-%m-%d")
    end
  end

  private

  def expect_nitro_page(name, function)
    path = pondo_page(name)
    expect_script("pondoTesting.#{function}('#{path}')")
  end
end

World(PondoTestingUtils)
