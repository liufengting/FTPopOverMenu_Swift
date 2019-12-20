![FTPopOverMenu](https://github.com/liufengting/FTResourceRepo/blob/master/Resource/FTPopOverMenu_logo/logotype_1280.png?raw=true)

[![Twitter](https://img.shields.io/badge/twitter-@liufengting-blue.svg?style=flat)](http://twitter.com/liufengting) 
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/liufengting/FTPopOverMenu_Swift/master/LICENSE)
[![Version](https://img.shields.io/cocoapods/v/FTPopOverMenu_Swift.svg?style=flat)](http://cocoapods.org/pods/FTPopOverMenu_Swift)
[![Download](https://img.shields.io/cocoapods/dt/FTPopOverMenu_Swift.svg?maxAge=2592000)](http://cocoapods.org/pods/FTPopOverMenu_Swift)
[![CocoaPods](https://img.shields.io/cocoapods/at/FTPopOverMenu_Swift.svg?maxAge=2592000)](http://cocoapods.org/pods/FTPopOverMenu_Swift)
[![GitHub stars](https://img.shields.io/github/stars/liufengting/FTPopOverMenu_Swift.svg)](https://github.com/liufengting/FTPopOverMenu_Swift/stargazers)


Swift version of [FTPopOverMenu](https://github.com/liufengting/FTPopOverMenu).

# FTPopOverMenu

[FTPopOverMenu](https://github.com/liufengting/FTPopOverMenu) is a pop over menu for `iOS` which is maybe the easiest one to use, supports both `portrait` and `landscape`. It can show from any `UIView`, any `UIBarButtonItem` and any `CGRect`. Simplest APIs, enable you to change the style in one line of code.

somtimes I want to customer every cell, so I seperate the global setting, and cell setting. e.g: my PM want some menu item are show but can't tap for some reason.

# ScreenShots

![screenshot](https://raw.githubusercontent.com/liufengting/FTResourceRepo/master/Resource/FTPopOverMenu/screenshots.gif)

# Installation

## Manually

* clone this repo.
* Simply drag and drop the '/FTPopOverMenu_Swift/FTPopOverMenu.swift' file into your project.

## CocoaPods

`FTPopOverMenu_Swift` is available through [CocoaPods](https://cocoapods.org/pods/FTPopOverMenu_Swift). To install it, simply add the following line to your `Podfile`:

* For Swift 4, please use version <= 0.1.4
* For Swift 5, please use version >= 0.2.0
* Big API change at 0.3.0, update at your own risk. [![Version](https://img.shields.io/cocoapods/v/FTPopOverMenu_Swift.svg?style=flat)](http://cocoapods.org/pods/FTPopOverMenu_Swift)


```ruby
target 'MyApp' do
    pod 'FTPopOverMenu_Swift', '~> 0.1.4'
end
```
Then run a pod install inside your terminal, or from CocoaPods.app.

# Usage

## Customize

Do any of the following settings to set the style (Only set the ones you want to change), maybe do this when app starts or when you want it to show a different style, but remember it's global change.

```swift
    let configuration = FTConfiguration.shared
    configuration.menuRowHeight = ...
    configuration.menuWidth = ...
    configuration.textColor = ...
    configuration.textFont = ...
    configuration.tintColor = ...
    configuration.borderColor = ...
    configuration.borderWidth = ...
    configuration.textAlignment = ...
    configuration.ignoreImageOriginalColor = ...;
    // set 'ignoreImageOriginalColor' to YES, images color will be same as textColor
```

## From SenderView, Menu Without Images.
 
```swift
        FTPopOverMenu.showForSender(sender: sender,
                                    with: ["Share"],
                                    done: { (selectedIndex) -> () in
                              
                                        print(selectedIndex)
        }) {
            
        }
```

## From SenderView, Menu With Images.
 
```swift
        FTPopOverMenu.showForSender(sender: sender,
                                    with: ["Share"],
                                    menuImageArray: ["iconImageName"],
                                    done: { (selectedIndex) -> () in
                              
                                        print(selectedIndex)
        }) {
            
        }
```
## From SenderFrame/NavigationItem, Menu Without Images.
 
```swift
        FTPopOverMenu.showFromSenderFrame(senderFrame: sender.frame,
                                          with: ["Share"],
                                          done: { (selectedIndex) -> () in
                                            
        }) {
            
        }
```

## From SenderFrame/NavigationItem, Menu With Images.
 
```swift
        FTPopOverMenu.showFromSenderFrame(senderFrame: sender.frame,
                                          with: ["Share"],
                                          menuImageArray: ["iconImageName"],
                                          done: { (selectedIndex) -> () in
                                            
        }) {
            
        }
```

## From barButtonItems .

- First: add action with event to you barButtonItems 

```swift
    @IBAction func handleAddBarButtonItem(_ sender: UIBarButtonItem, event: UIEvent) {
        
        FTPopOverMenu.showForEvent(event: event,
                                   with: ["Share"],
                                   menuImageArray: ["iconImageName"],
                                   done: { (selectedIndex) -> () in
        
        }) {
            
        }
    }
```

# CHANGELOG

[CHANGELOG](https://github.com/liufengting/FTPopOverMenu_Swift/blob/master/CHANGELOG.md)

# More

* Swift version of [FTPopOverMenu](https://github.com/liufengting/FTPopOverMenu).
* Logo Designed by @Tobaloidee
* Images in the demo from [https://www.iconfinder.com/iconsets/pokemon-go](https://www.iconfinder.com/iconsets/pokemon-go).
* If you like it, or maybe wanna use it in your own projects, please give me a `star`.
* Looking for another way of doing this? Take a look at my another [FTPopMenu at here](https://github.com/liufengting/FTPopMenu).  It was another way of showing pop over menus, which is wrapped from `UIPopoverViewController`, and more genetic and more good-looking. Feel free to try it.

# License

`FTPopOverMenu_Swift` is available under the `MIT` license. See the `LICENSE` file for more info.


