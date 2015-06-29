RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def fake_io_with_input(fake_input)
    fake_input = StringIO.new(fake_input)
    fake_output = StringIO.new
    $stdin = fake_input
    $stdout = fake_output

    yield(fake_input, fake_output)

    $stdin = STDIN
    $stdout = STDOUT
  end
end
