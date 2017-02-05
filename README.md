# Burn After Reading

A tiny script to generate a printable HTML page (with QR codes) to back up
your TOTP secrets,
[SSSS](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing) passphrase
shards, etc.

## Usage

    bundle install

    # There are two options for encrypting the YAML data, choose one...
    # 1. Recommended: a private key in your keyring
    echo 'foo: 12345678901234567890' | gpg --encrypt --recipient USER_ID > my-secrets.yml.gpg
    # 2. Symmetric encryption with only a passphrase
    gpg -o my-secrets.yml.gpg --symmetric <(echo 'foo: 12345678901234567890')

    bundle exec ./burn-after-reading my-secrets.yml.gpg
    open my-secrets.html

## Running Tests

    bundle exec rake test
