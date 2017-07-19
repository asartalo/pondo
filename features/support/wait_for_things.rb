module WaitForThings
  def wait_for_page_load
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_loading?
    end
  end

  def finished_loading?
    jscript('document.getElementsByClassName("testing-visiting").length').zero?
  end

  def wait_for_remote_request
    wait_for_page_load
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def pause_pls
    $stderr.write 'Press enter to continue'
    $stdin.gets
  end
end

World(WaitForThings)
