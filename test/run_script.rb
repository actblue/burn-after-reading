#!/usr/bin/env ruby

require 'minitest/autorun'

class TestBarScript < Minitest::Test
  BURN_SCRIPT = File.expand_path('../burn-after-reading', __dir__)
  TEST_SECRETS_FILE = File.expand_path('acme.yml.gpg', __dir__)
  PASSPHRASE = 'correct.horse.battery.staple'

  def setup
    ENV['BURN_GPG_ARGS'] = "--batch --passphrase #{PASSPHRASE}"
    ENV['BURN_PLATFORM'] = 'test'
    ENV['BROWSER'] = 'echo'
  end

  def test_run_and_output_html
    out, err = capture_subprocess_io { system BURN_SCRIPT, TEST_SECRETS_FILE }
    assert_match %r[^data:text/html,], out
    assert_match %r[Acme Password], out
    assert_match %r[Acme 2FA], out
    assert_match %r[otpauth://totp/Acme], out
    assert_empty err
  end
end
