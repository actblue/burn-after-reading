# Burn After Reading

A tiny script to generate a printable HTML page (with QR codes) to back up
your TOTP secrets,
[SSSS](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing) passphrase
shards, etc.

## Usage

    bundle install
    echo 'foo: 12345678901234567890' | gpg --encrypt > my-secrets.yml.gpg
    bundle exec ./burn-after-reading my-secrets.yml.gpg
    open my-secrets.html

## Running Tests

    bundle exec rake test
