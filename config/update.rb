temporary_gems = %w{
  devise
  simple_form
}
expires = Date.parse("01 June 2017")
if Date.current > expires
  raise "Please check if the temporary gems #{temporary_gems.join(', ')} can be resolved to current"
end
