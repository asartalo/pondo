module WaitForThings
  def wait_for_page_load
    puts "WAIT FOR PAGE LOAD: #{Capybara.default_max_wait_time}"
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_loading?
    end
  end

  def finished_loading?
    page.evaluate_script('jQuery(".testing-visiting").length').zero?
  end

  def wait_for_ajax
    puts "WAIT: #{Capybara.default_max_wait_time}"
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end
end

World(WaitForThings)
