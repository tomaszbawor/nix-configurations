# Nix Configuration Files

## Check Flake

Validate if everything is fine

```bash
nix flake check --all-systems
```

## Install

### Macbooks

Work:

```bash
darwin-rebuild switch --flake .#work
```

Private

```bash
darwin-rebuild switch --flake .#private
```

## Installing nix on Macos

<https://nixos.org/download/>

It all comes to the following command:

```bash
 sh <(curl -L https://nixos.org/nix/install)
```

## Enabling experimental features on macos

In order to run nix flakes you need to modify your `/etc/nix/nix.conf` by adding line

```text
experimental-features = nix-command flake
```

## Root Certificates

Sometimes on your work machines your traffic is being routed through a TLS proxy which can cause issues with nix.

In order to fix this you may need to export your macbook keychain certs and import them into nix:

This is described in <https://discourse.nixos.org/t/ssl-ca-cert-error-on-macos/31171/6>

Export all trusted certs into bundle:

```bash
security export -t certs -f pemseq -k /Library/Keychains/System.keychain -o /tmp/certs-system.pem
security export -t certs -f pemseq -k /System/Library/Keychains/SystemRootCertificates.keychain -o /tmp/certs-root.pem
cat /tmp/certs-root.pem /tmp/certs-system.pem > /tmp/ca_cert.pem
```

Copy bundle to `/etc/nix`

```bash
sudo mv /tmp/ca_cert.pem /etc/nix/
```

Edit `launchctl plist` of nix-daemon

```bash
sudo vim /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

And ensure that we have proper records:

```xml
    <key>EnvironmentVariables</key>
    <dict>
      <key>NIX_SSL_CERT_FILE</key>
      <string>/etc/nix/ca_cert.pem</string>
      <key>SSL_CERT_FILE</key>
      <string>/etc/nix/ca_cert.pem</string>
      <key>REQUEST_CA_BUNDLE</key>
      <string>/etc/nix/ca_cert.pem</string>
    </dict>
```

After saving restart your computer or try to restart nix-daemon

```bash
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

```bash
sudo launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist
```

````bash

If that do not work you may also need to export ith
```bash
export NIX_SSL_CERT_FILE=/etc/nix/ca_cert.pem
export SSL_CERT_FILE=/etc/nix/ca_cert.pem
````

## Formatting files

```bash
nix fmt .
```

## Activation of home configuration for macos for first time

After installing nix we do not have proper settings set up that is why we need to run the following command:

```bash
nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:LnL7/nix-darwin -- switch --flake .#work
```

afterwards the subsequent updates can be done by running:

```bash
darwin-rebuild switch --flake .#work
```

## Exporting dconf

```bash
dconf dump / | dconf2nix > dconf.nix
```

## Known Problems

- <https://github.com/NixOS/nix/issues/8771#issuecomment-1662633816>
- <https://discourse.nixos.org/t/issues-with-nix-and-custom-tls-cert-bundle/29483>
- <https://github.com/NixOS/nix/issues/7808> Zscaler issue

## Inspirations

- <https://github.com/zmre/mac-nix-simple-example>
