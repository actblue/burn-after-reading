#!/usr/bin/env ruby

require 'minitest/autorun'

class TestBarScript < Minitest::Test
  BAR_SCRIPT = File.expand_path('../burn-after-reading', __dir__)
  TEST_SECRETS_FILE = File.expand_path('acme.yml.gpg', __dir__)
  TEST_OUTPUT_FILE = File.expand_path('acme.html', __dir__)
  PASSPHRASE = 'correct.horse.battery.staple'

  def setup
    ENV['BURN_GPG_ARGS'] = "--batch --passphrase #{PASSPHRASE}"
  end

  def test_run_and_create_html
    system BAR_SCRIPT, TEST_SECRETS_FILE
    assert File.exist? TEST_OUTPUT_FILE
    assert_match 'acme-whatever', File.read(TEST_OUTPUT_FILE)
  end

  def teardown
    File.unlink(TEST_OUTPUT_FILE)
  end
end
