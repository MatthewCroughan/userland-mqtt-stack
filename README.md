# Install

![UserLAnd](https://userland.tech/static/phone-feature-horizontal-be4009ad7e0ee7ab5c3607b4f9d92977.gif)

To install this on UserLAnd inside a linux container, first you have to download UserLAnd from [F-droid](https://f-droid.org/en/) or the [google play store.](https://play.google.com/store/apps/details?id=tech.ula)

After installing UserLAnd, make a fresh debian VM. This should be easy, as it prompts you for a username and password upon clicking the Debian icon.

Run `./install` inside the container

# Usage

After installing, the stack will start up with the container via crontab's `@reboot`. 

In the home directory of your user there exists `~/killstack.sh` and `startstack.sh` should the stack ever fail you for some reason. Though this is un-necessary otherwise. 

# Sidenote

It seems the services are reliable enough to not need an init system or service manager for our testing purposes. However, I may be able to look more deeply into this and create a UserLAnd asset to do this same thing, more reliably and with a single click like an application. 
