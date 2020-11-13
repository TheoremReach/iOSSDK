# TheoremReach iOS-SDK

TheoremReach iOS SDK v3.4.2

For additional information, please see the [TheoremReach iOS SDK Integration](https://theoremreach.com/docs/ios).

## Changelog

### v3.4.2
- Fix code signing issue

### v3.4.1
- Fix LC_VERSION_MIN_IPHONEOS to now be 14.0 error

### v3.4.0
- Future proof for iOS 14
- Fix iPadOS display issue with the reward center viewcontroller

### v3.3.6
- Fixing iPad bug for iOS 13

## Cocoapods:

Add the following to your `podfile`

  ```groovy
  pod 'TheoremReach', ‘3.4.2’
  ```

  #### Manual:

  Download the latest version of the [TheoremReach iOS SDK](https://github.com/theoremreach/iOSSDK) and add the **TheoremReachSDK.framework** to your project. Follow the integration guide to setup your application to use TheoremReach.
  
  #### Simulator:
  
  In order to run the TheoremReach iOS SDK on a simulator, you'll need to use the simulator specific framework located [here](https://github.com/TheoremReach/TheoremReach-iOS-SDK-Podfile/tree/master/simulator).
  
  If you're using Cocoapods, download the [TheoremReach-iOS-SDK-Podfile](https://github.com/TheoremReach/TheoremReach-iOS-SDK-Podfile.git) repository and then add the following to your `podfile`
  
  ```groovy
  pod 'TheoremReach', :path => '/{path to folder containing the repo}/TheoremReach-iOS-SDK-Podfile/simulator'
  ```

## Other platforms:

[TheoremReach Android SDK Integration](https://theoremreach.com/docs/android)

[TheoremReach Unity SDK Integration](https://theoremreach.com/docs/unity)

[TheoremReach Javascript Web SDK Integration](https://theoremreach.com/docs/web)  
