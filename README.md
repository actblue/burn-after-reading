# Burn After Reading

A small script to generate a printable HTML page (with QR codes) to back up
your OTP secrets,
[SSSS](https://en.wikipedia.org/wiki/Shamir%27s_Secret_Sharing) passphrase
shards, etc.

Secrets are never written unencrypted to disk; they're read from an encrypted
file and the output is opened in your browser as a `data:text/html` URI.

## Input

Your secret data is read from a GPG-encrypted YAML file. The YAML should
contain one hash, where the keys are service names (used as headings in
the HTML page) and the values are secrets.

A secret value can be a string, which will used literally, or a hash
with one key, either `:totp` or `:hotp`, in which case it will be
converted into a
[key URI that you can scan in any Google Authenticator-compatible app](https://github.com/google/google-authenticator/wiki/Key-Uri-Format),
with the rest of the data like so:

    Example Service:
      :totp:
        Example:alice@google.com:
          secret: JBSWY3DPEHPK3PXP
          issuer: Example

You can add whatever other parameters you need nested under the label.

## Usage

Install dependencies:

    bundle install

There are two options for encrypting the YAML data, choose one:

 1. A private key in your keyring (recommended)

        echo 'Foo: abcdef1234567890' | gpg --encrypt --recipient USER_ID > my-secrets.yml.gpg

 2. Symmetric encryption with only a passphrase

        gpg -o my-secrets.yml.gpg --symmetric <(echo 'Foo: abcdef1234567890')

Open the HTML page in your browser:

    bundle exec ./burn-after-reading my-secrets.yml.gpg

This uses the environment variable `BURN_MAC_BROWSER` (default `Safari`)
on macOS and `BROWSER` (default `xdg-open`) on other platforms.

## Security Notes

You should avoid creating a temporary YAML file on disk and then encrypting
it, because then the unencrypted data will physically remain on the disk even
after deleting the file. Also, don't use the example `echo | gpg` commands
literally with real data, since they will be written to your shell history.
Instead, try one of:

  * Using
    [Emacs's built-in GPG support](https://www.gnu.org/software/emacs/manual/html_node/epa/Encrypting_002fdecrypting-gpg-files.html).
    If you visit a new file with a name ending in `.gpg`, when you save it,
    you'll be prompted to interactively select either recipient keys or a
    symmetric passphrase.

  * Adapting the example commands to read data from the system clipboard
    (instead of `echo`ing the literal YAML), and put data there from an
    unsaved scratch buffer in your favorite editor.

## Running Tests

    bundle exec rake test
