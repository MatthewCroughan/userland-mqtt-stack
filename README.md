![UserLAnd](https://userland.tech/static/phone-feature-horizontal-be4009ad7e0ee7ab5c3607b4f9d92977.gif)

# Install

To install this stack on UserLAnd inside a linux container, first you have to download UserLAnd from [F-droid](https://f-droid.org/en/) or the [google play store.](https://play.google.com/store/apps/details?id=tech.ula)

After installing UserLAnd on your device, make a fresh Debian container. 

The IP Address of your phone can be used via UserLAnd on port 2022. You can find out your phone's ip in the Android settings under "About Phone"
`ssh username@ip.address.here -p 2022`

Now your container is set up, get the install script from this git directory somehow and run it inside the container.

This could be done in a few ways:

Via curl
```
bash <(curl -s https://raw.githubusercontent.com/MatthewCroughan/userland-mqtt-stack/master/install.sh)
```

Via wget and running directly
```
wget https://raw.githubusercontent.com/MatthewCroughan/userland-mqtt-stack/master/install.sh
chmod +x install.sh
./install.sh`
```

Cloning the repository and running
```
git clone https://github.com/MatthewCroughan/userland-mqtt-stack.git
cd userland-mqtt-stack
./install.sh
```


# Usage

After installing, the stack will start up with the container via crontab's `@reboot`. 

You can simply start and stop the container by hold-pressing the icon/button for your container in UserLAnd.

`~/killstack.sh` and `~/startstack.sh` are scripts that do what they say on the tin, should the stack ever fail you for some reason.

# Notes

It seems the services are reliable enough to not need an init system or service manager for our testing purposes. However, I may be able to look more deeply into this and create a UserLAnd asset to do this same thing, more reliably and with a single click like an application. 

Some devices seem to need probing in order to install anything, since their power saving features are too integrated into the system. I've added a throbber in the hopes that this alleviates that issue.

