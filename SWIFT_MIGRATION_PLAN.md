# Plan: Duplicate iOS SDK Repository and Migrate to Swift

## Overview
Duplicate the existing iOSSDK repository into a new `iOSSDK-Swift-Storyboard` repository and migrate all Objective-C code to Swift while preserving framework compatibility and project structure.

**Migration Philosophy:** This is a **Swift language migration**, not a UI framework modernization. We're converting Objective-C → Swift while maintaining the original UIKit + Storyboard architecture. This approach:
- Validates TheoremReachSDK compatibility with modern Swift apps
- Minimizes migration risk by changing one thing at a time
- Creates a stable foundation for future UI modernization (SwiftUI) if desired

**Future Consideration:** After confirming SDK compatibility, the `iOSSDK-Swift-SwiftUI` repository can migrate from Storyboards to SwiftUI as a separate project.

## Project Context
- **Root Directory:** `/Users/andykeller/Code/iOS-Apps/`
- **Original Project:** `/Users/andykeller/Code/iOS-Apps/iOSSDK/`
- **Storyboard Migration:** `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/`
- **SwiftUI Migration:** `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/` (future)
- **Current State:** Objective-C example app integrating TheoremReachSDK and PlaytimeMonetize frameworks
- **Files to Migrate:** 3 Objective-C files (AppDelegate, ViewController, main)
- **Frameworks:** 2 xcframeworks (binary, no source changes needed)

## Implementation Steps

### PREREQUISITE: User Creates New Xcode Project
**Status:** ✅ COMPLETED

Base Xcode project created with these settings:
- **Location:** `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/`
- **Project Structure:** `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj`
- **Template:** iOS → App
- **Product Name:** `TheoremReachiOSExampleApp`
- **Team:** (user's development team)
- **Organization Identifier:** `com.theoremreach`
- **Bundle Identifier:** `com.theoremreach.TheoremReachiOSExample`
- **Interface:** **Storyboard** ✅
- **Language:** Swift
- **Storage:** None (no Core Data)
- **Include Tests:** Optional (not required for example app)

**IMPORTANT - Interface Selection:**
- **Storyboard (Recommended):** Choose this to maintain the original app architecture. We can directly copy the existing Main.storyboard and LaunchScreen.storyboard files. Migration is straightforward - just convert code from Objective-C to Swift.

- **SwiftUI:** This would be a complete UI rewrite, not just a migration. The original app uses UIKit + Storyboards with:
  - Interface Builder layouts
  - IBAction connections for the "Take Surveys!" button
  - Storyboard segues and view controller presentation

  Choosing SwiftUI means you'd need to:
  - Rewrite all UI code from scratch in SwiftUI
  - Convert UIViewController-based architecture to SwiftUI Views
  - Replace IBAction patterns with SwiftUI button actions
  - Potentially restructure the app lifecycle

  This is a modernization project, not a Swift migration. Estimated effort is 3-5x more work.

**Recommendation:** Use **Storyboard** interface to keep this as a straightforward Objective-C → Swift migration.

Current project structure:
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj/` (properly configured for Swift)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/AppDelegate.swift` (default template - will be replaced)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/SceneDelegate.swift` (needs to be deleted)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/ViewController.swift` (default template - will be replaced)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Base.lproj/Main.storyboard` (default - will be replaced)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Base.lproj/LaunchScreen.storyboard` (default - will be replaced)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Assets.xcassets` (default - will be merged/replaced)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Info.plist`

### 1. Copy Frameworks to New Repository
**Action:** Add binary frameworks to project directory

1.1. Copy framework files to project directory:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachSDK.xcframework/`
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/PlaytimeMonetize.xcframework/`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/`
   - Copy both xcframework bundles to the project directory (next to the .xcodeproj file)

1.2. Add frameworks to Xcode project:
   - Drag frameworks into Xcode project navigator
   - Select "Copy items if needed"
   - Add to target: TheoremReachiOSExampleApp
   - Verify "Embed & Sign" in General → Frameworks, Libraries, and Embedded Content

### 2. Replace Resources with Original Assets
**Action:** Copy UI resources from original project

2.1. Replace storyboards:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachiOSExampleApp/Base.lproj/Main.storyboard`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Base.lproj/Main.storyboard`
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachiOSExampleApp/Base.lproj/LaunchScreen.storyboard`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Base.lproj/LaunchScreen.storyboard`

2.2. Replace/merge assets:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachiOSExampleApp/Assets.xcassets/`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Assets.xcassets/`
   - Replace entire Assets.xcassets folder (includes AppIcon)

2.3. Update Info.plist:
   - File: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Info.plist`
   - Add `NSUserTrackingUsageDescription` key
   - Add `NSAppTransportSecurity` dictionary with `NSAllowsArbitraryLoads = YES`
   - Update `CFBundleDisplayName` to "TheoremReach Demo App"
   - Configure supported orientations (all 4 orientations)

2.4. Copy entitlements:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.entitlements`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.entitlements`
   - Update project settings to reference entitlements file

2.5. Copy documentation:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/README.md`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/README.md`
   - Update README to reference Swift version
   - Git repository already initialized (`.git` exists)

### 3. Swift Code Migration
**Action:** Replace template Swift files with properly migrated code

3.1. **Replace AppDelegate.swift**
   - Replace Xcode's default AppDelegate.swift with migrated version
   - Handle SceneDelegate (if created by Xcode template):
     - Delete SceneDelegate.swift (not used in original app)
     - Remove scene configuration from Info.plist if present
   - Convert to Swift class with `@main` annotation (replaces main.m)
   - Implement `UIApplicationDelegate` protocol
   - Implement TheoremReach delegates:
     - `TheoremReachRewardDelegate`
     - `TheoremReachSurveyDelegate`
     - `TheoremReachSurveyAvailableDelegate`
   - Import required frameworks:
     - `UIKit`
     - `WebKit`
     - `TheoremReachSDK`
     - `AppTrackingTransparency`
   - Preserve all initialization logic and delegate methods
   - Key methods to migrate:
     - `application(_:didFinishLaunchingWithOptions:)` - create window manually
     - `initializeTheoremReachSDK()`
     - `askForIDFAPermissions()`
     - All delegate callbacks (onReward, onRewardCenterOpened, etc.)
     - App lifecycle methods

3.2. **Replace ViewController.swift**
   - Replace Xcode's default ViewController.swift
   - Convert to Swift `UIViewController` subclass
   - Preserve storyboard connection (customClass="ViewController")
   - Migrate methods:
     - `viewDidLoad()`
     - `viewDidAppear(_:)`
     - `initializeTheoremReachSDK()`
     - `launchTheoremReach(_:)` IBAction
   - Maintain AppDelegate access pattern for IDFA permissions

3.3. **Handle SceneDelegate vs Traditional App Lifecycle**
   - Original app uses pre-iOS 13 app lifecycle (no SceneDelegate)
   - New Xcode templates (iOS 13+) create SceneDelegate by default
   - Options:
     - **Option A (Simpler):** Delete SceneDelegate, use traditional AppDelegate with window property
     - **Option B:** Keep SceneDelegate and modernize the app
   - **Recommended:** Use Option A to match original architecture

### 4. Xcode Project Configuration
**Action:** Configure build settings and link frameworks (project already created by user)

4.1. Configure build settings in Xcode:
   - Set Deployment Target: iOS 14.0 (to match original)
   - Verify `TARGETED_DEVICE_FAMILY = 1,2` (iPhone & iPad)
   - Set `ENABLE_BITCODE = NO` (frameworks don't support bitcode)
   - Verify `SWIFT_VERSION = 5.0` or latest
   - Set `CODE_SIGN_ENTITLEMENTS = TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.entitlements`

4.2. Framework integration (already partially done in Step 1.2):
   - Verify frameworks are in "Embed & Sign" mode in General tab
   - If needed, add framework search paths: `$(PROJECT_DIR)` in Build Settings
   - Verify "Embed Frameworks" build phase exists
   - Confirm framework attributes: `CodeSignOnCopy`, `RemoveHeadersOnCopy`

4.3. Link system frameworks:
   - Add required frameworks in General → Frameworks, Libraries, and Embedded Content:
     - WebKit.framework
     - JavaScriptCore.framework
     - Security.framework
     - SystemConfiguration.framework
     - CoreTelephony.framework
     - AdSupport.framework
     - ExternalAccessory.framework
     - AppTrackingTransparency.framework
   - UIKit and Foundation are linked by default

4.4. Configure Info.plist (already partially done in Step 2.3):
   - Verify all changes from Step 2.3 are applied
   - If SceneDelegate was created, remove scene manifest:
     - Delete `UIApplicationSceneManifest` dictionary from Info.plist

4.5. Update Main.storyboard:
   - Verify ViewController customClass is set to "ViewController"
   - Verify module is set to "TheoremReachiOSExampleApp" (or inherit)
   - Verify IBAction connection for `launchTheoremReach` button exists

### 5. Bridging & Module Configuration
**Action:** Ensure framework interoperability

5.1. **No Bridging Header Needed**
   - TheoremReachSDK has module.modulemap (importable as framework)
   - PlaytimeMonetize is Swift framework (direct import)
   - Import statements in Swift: `import TheoremReachSDK`

5.2. Framework module imports:
   - Verify TheoremReachSDK umbrella header exposes all APIs
   - Use Swift syntax for Objective-C framework calls
   - Handle any optionality differences between Objective-C and Swift

### 6. Git Repository Setup
**Action:** Setup version control for new repository

6.1. Git repository status:
   - ✅ Git repository already initialized at `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/.git`
   - No additional initialization needed

6.2. Update `.gitignore`:
   - Check if `.gitignore` exists in project root
   - Ensure it includes:
     ```gitignore
     .DS_Store
     xcuserdata/
     DerivedData/
     *.xcuserstate
     build/
     *.pbxuser
     *.mode1v3
     *.mode2v3
     *.perspectivev3
     ```

6.3. README.md already copied (Step 2.5):
   - Verify README references Swift Storyboard version
   - Update installation instructions if needed
   - Mention this is the Swift version of the SDK example

6.4. Initial commit (after migration complete):
   ```bash
   cd /Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp
   git add .
   git commit -m "Initial commit: Swift migration of TheoremReach iOS SDK example app

   - Migrated AppDelegate from Objective-C to Swift
   - Migrated ViewController from Objective-C to Swift
   - Updated project configuration for Swift
   - Added TheoremReachSDK and PlaytimeMonetize frameworks
   - Configured all required system frameworks
   "
   ```

6.5. Create remote repository (optional):
   - User may want to push to GitHub as `TheoremReach/iOSSDK-Swift-Storyboard`
   - Can be done later as needed

### 7. Code Translation Details

#### AppDelegate.swift Key Conversions:

**Objective-C Pattern → Swift Pattern:**
- `@interface AppDelegate : UIResponder <UIApplicationDelegate>` → `class AppDelegate: UIResponder, UIApplicationDelegate`
- `@property (strong, nonatomic) UIWindow *window` → `var window: UIWindow?`
- `NSClassFromString(@"...")` → `NSClassFromString("...")`
- `[TheoremReach colorWithHexString:@"#1B0C47"]` → `TheoremReach.colorWithHexString("#1B0C47")`
- `[TheoremReach initWithApiKey:@"..." userId:@"..."]` → `TheoremReach.initWithApiKey("...", userId: "...")`
- `[TheoremReach getInstance]` → `TheoremReach.getInstance()`
- `[tr setRewardListenerDelegate:self]` → `tr.setRewardListenerDelegate(self)`
- Block syntax → Closure syntax
- `NSLog(@"...")` → `print("...")`
- Switch statement enum cases preserve naming

**Delegate Methods:**
- `- (void)onReward:(NSNumber *)quantity` → `func onReward(_ quantity: NSNumber)`
- `- (void)theoremreachSurveyAvailable:(BOOL)surveyAvailable` → `func theoremreachSurveyAvailable(_ surveyAvailable: Bool)`

#### ViewController.swift Key Conversions:

- `- (IBAction)launchTheoremReach:(id)sender` → `@IBAction func launchTheoremReach(_ sender: Any)`
- `(AppDelegate*)[UIApplication sharedApplication].delegate` → `UIApplication.shared.delegate as? AppDelegate`
- `dispatch_async(dispatch_get_main_queue(), ^{...})` → `DispatchQueue.main.async {...}`

## Critical Files

### Files to Create/Replace:
- `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/AppDelegate.swift`
- `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/ViewController.swift`
- `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/README.md`
- Update: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj/project.pbxproj`

### Files to Delete:
- `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/SceneDelegate.swift` (not needed - using traditional AppDelegate)

### Files from Original (Reference Only):
- `main.m` (not needed in Swift - replaced by @main annotation)
- `AppDelegate.h/.m` (will be converted to AppDelegate.swift)
- `ViewController.h/.m` (will be converted to ViewController.swift)

## Verification Steps

### Build Verification:
1. Open `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-Storyboard/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj` in Xcode
2. Select a simulator target (e.g., iPhone 15 Pro or iPhone 16 Pro)
3. Build project (⌘B) - should compile without errors
4. Verify frameworks are properly embedded
5. Check for Swift compilation warnings

### Runtime Verification:
1. Run app in simulator
2. Verify app launches successfully
3. Test "Take Surveys!" button triggers `launchTheoremReach` action
4. Verify IDFA permission prompt appears (on first launch)
5. Verify TheoremReach SDK initializes (check console logs)
6. Confirm TheoremReach reward center opens
7. Test delegate callbacks fire correctly:
   - onRewardCenterOpened
   - onRewardCenterClosed
   - theoremreachSurveyAvailable

### Code Review Verification:
1. Verify all Objective-C patterns properly converted to Swift idioms
2. Check proper use of optionals (`?` and `!`)
3. Ensure delegate protocol conformance
4. Verify framework imports work correctly
5. Check storyboard IBOutlet/IBAction connections intact

### Git Verification:
1. Verify `.gitignore` excludes user-specific files
2. Confirm initial commit includes all necessary files
3. Check that xcuserdata and build artifacts are not tracked

## Notes

### Potential Issues:
1. **Framework Compatibility:** TheoremReachSDK is Objective-C framework. Swift should import it seamlessly via module map, but verify API availability.

2. **PlaytimeMonetize Styling:** The `appearanceWhenContainedInInstancesOfClasses` call in `didFinishLaunchingWithOptions` uses runtime class lookup. Ensure Swift equivalent works:
   ```swift
   if let frameworkVCClass = NSClassFromString("PlaytimeMonetize.WebOfferwallViewController"),
      let wkScrollClass = WKScrollView.self as? UIAppearance.Type {
       // Swift appearance proxy setup
   }
   ```

3. **Bundle Identifier:** Verify code signing works with bundle ID `com.theoremreach.TheoremReachiOSExample` or use development team's identifier.

4. **SceneDelegate Handling:** Modern Xcode templates create SceneDelegate by default. Must remove it to match original app's architecture (pre-iOS 13 style).

5. **Window Management:** AppDelegate must manually create and manage the window property since we're not using SceneDelegate:
   ```swift
   var window: UIWindow?

   func application(_ application: UIApplication, didFinishLaunchingWithOptions...) -> Bool {
       window = UIWindow(frame: UIScreen.main.bounds)
       window?.makeKeyAndVisible()
       // ... rest of initialization
   }
   ```

### Execution Order (Phase 1 - Storyboard):
1. ✅ **COMPLETED:** Create new Xcode project with specified settings (PREREQUISITE section)
2. **Next:** Copy frameworks to project directory
3. **User:** Drag frameworks into Xcode and set to "Embed & Sign" (or agent can guide)
4. **Agent:** Copy/replace resources (storyboards, assets, plists)
5. **Agent:** Delete SceneDelegate.swift and update Info.plist
6. **Agent:** Replace Swift files with migrated code
7. **User/Agent:** Configure build settings and link system frameworks
8. **Agent:** Create initial commit
9. **User + Agent:** Build and verify together

---

# PHASE 2: SwiftUI Migration

## Overview
After completing Phase 1 (Storyboard migration), Phase 2 migrates the app to SwiftUI. This is a **UI framework modernization**, converting from UIKit + Storyboards to SwiftUI while preserving the TheoremReach SDK integration logic.

## Project Context (Phase 2)
- **Location:** `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/`
- **Project Structure:** `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj`
- **Reference:** Phase 1 Storyboard project provides working Swift SDK integration code
- **Migration Type:** UIKit → SwiftUI (complete UI rewrite)
- **SDK Integration:** Reuse logic from Phase 1, adapt for SwiftUI lifecycle

## Prerequisites (Phase 2)

### PREREQUISITE: User Creates SwiftUI Xcode Project
**Status:** ✅ COMPLETED

Base SwiftUI Xcode project created with these settings:
- **Location:** `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/`
- **Project Structure:** `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj`
- **Template:** iOS → App
- **Product Name:** `TheoremReachiOSExampleApp`
- **Team:** (user's development team)
- **Organization Identifier:** `com.theoremreach`
- **Bundle Identifier:** `com.theoremreach.TheoremReachiOSExampleSwiftUI`
- **Interface:** **SwiftUI** ✅
- **Language:** Swift
- **Storage:** None (no Core Data)
- **Include Tests:** Optional

Current project structure (SwiftUI template):
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj/`
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/TheoremReachiOSExampleAppApp.swift` (App protocol entry point)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/ContentView.swift` (main SwiftUI view)
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Assets.xcassets`
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Preview Content/`
- `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Info.plist` (if present)

## Implementation Steps (Phase 2)

### 1. Copy Frameworks to SwiftUI Project
**Action:** Add binary frameworks (same as Phase 1)

1.1. Copy framework files:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachSDK.xcframework/`
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/PlaytimeMonetize.xcframework/`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp/`
   - Copy both xcframework bundles to project directory (next to .xcodeproj)

1.2. Add frameworks to Xcode project:
   - Drag frameworks into Xcode project navigator
   - Select "Copy items if needed"
   - Add to target: TheoremReachiOSExampleApp
   - Verify "Embed & Sign" in General → Frameworks, Libraries, and Embedded Content

### 2. Copy Resources (Assets Only)
**Action:** Copy non-UI resources from original project

2.1. Replace assets:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachiOSExampleApp/Assets.xcassets/`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Assets.xcassets/`
   - Replace entire Assets.xcassets folder (includes AppIcon)

2.2. Update Info.plist (if separate file exists):
   - File: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/Info.plist`
   - Or add to project's target Info in Xcode
   - Add `NSUserTrackingUsageDescription` key: "This app uses your data to provide personalized surveys"
   - Add `NSAppTransportSecurity` dictionary with `NSAllowsArbitraryLoads = YES`
   - Update `CFBundleDisplayName` to "TheoremReach Demo App"
   - Configure supported orientations (all 4 orientations)

2.3. Copy entitlements:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.entitlements`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.entitlements`
   - Update project settings to reference entitlements file

2.4. Copy documentation:
   - Source: `/Users/andykeller/Code/iOS-Apps/iOSSDK/README.md`
   - Destination: `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/README.md`
   - Update README to reference SwiftUI version

### 3. Create SwiftUI App Architecture
**Action:** Implement SwiftUI app structure with TheoremReach SDK integration

3.1. **Create AppDelegate for SDK Integration**
   - File: `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/AppDelegate.swift`
   - SwiftUI apps can still use AppDelegate via `UIApplicationDelegateAdaptor`
   - Implement SDK initialization in AppDelegate
   - Implement TheoremReach delegate protocols:
     - `TheoremReachRewardDelegate`
     - `TheoremReachSurveyDelegate`
     - `TheoremReachSurveyAvailableDelegate`
   - Import required frameworks:
     - `UIKit`
     - `SwiftUI`
     - `WebKit`
     - `TheoremReachSDK`
     - `AppTrackingTransparency`

3.2. **Update Main App File**
   - File: `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/TheoremReachiOSExampleAppApp.swift`
   - Add `@UIApplicationDelegateAdaptor` to connect AppDelegate
   - Initialize app with ContentView as root
   - Handle app lifecycle if needed

3.3. **Create ContentView**
   - File: `TheoremReachiOSExampleApp/TheoremReachiOSExampleApp/ContentView.swift`
   - Rewrite UI in SwiftUI:
     - Replace UIViewController with SwiftUI View
     - Create "Take Surveys!" button using SwiftUI Button
     - Add logo/branding using SwiftUI Image
     - Implement layout using VStack/HStack/ZStack
   - Access AppDelegate for TheoremReach SDK methods
   - Call `TheoremReach.getInstance().showRewardCenter()` on button tap

3.4. **Create TheoremReachView (UIViewControllerRepresentable)**
   - Optional: If TheoremReach SDK requires UIKit integration
   - Wrap SDK's UIViewController in SwiftUI-compatible wrapper
   - Handle presentation/dismissal in SwiftUI context

### 4. Xcode Project Configuration
**Action:** Configure build settings and link frameworks

4.1. Configure build settings:
   - Set Deployment Target: iOS 14.0 (or iOS 15.0+ for better SwiftUI support)
   - Verify `TARGETED_DEVICE_FAMILY = 1,2` (iPhone & iPad)
   - Set `ENABLE_BITCODE = NO` (frameworks don't support bitcode)
   - Verify `SWIFT_VERSION = 5.0` or latest
   - Set `CODE_SIGN_ENTITLEMENTS = TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.entitlements`

4.2. Framework integration:
   - Verify frameworks are in "Embed & Sign" mode
   - Add framework search paths if needed: `$(PROJECT_DIR)`
   - Verify "Embed Frameworks" build phase exists

4.3. Link system frameworks:
   - Add required frameworks in General → Frameworks, Libraries, and Embedded Content:
     - WebKit.framework
     - JavaScriptCore.framework
     - Security.framework
     - SystemConfiguration.framework
     - CoreTelephony.framework
     - AdSupport.framework
     - ExternalAccessory.framework
     - AppTrackingTransparency.framework
   - UIKit and Foundation linked by default

### 5. SwiftUI Code Implementation Details

#### App File Structure:
```swift
import SwiftUI

@main
struct TheoremReachiOSExampleAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appDelegate)
        }
    }
}
```

#### AppDelegate Structure (for SwiftUI):
```swift
import UIKit
import SwiftUI
import TheoremReachSDK
import AppTrackingTransparency
import WebKit

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    @Published var surveyAvailable: Bool = false

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize TheoremReach SDK
        initializeTheoremReachSDK()

        // Request IDFA permissions
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.askForIDFAPermissions()
        }

        return true
    }

    func initializeTheoremReachSDK() {
        // SDK initialization logic from Phase 1
        // Configure TheoremReach
        // Set delegates
    }

    func askForIDFAPermissions() {
        // IDFA permission logic from Phase 1
    }
}

// Implement TheoremReach delegate protocols
extension AppDelegate: TheoremReachRewardDelegate {
    func onReward(_ quantity: NSNumber) {
        // Handle reward
    }
}

extension AppDelegate: TheoremReachSurveyDelegate {
    // Implement survey delegate methods
}

extension AppDelegate: TheoremReachSurveyAvailableDelegate {
    func theoremreachSurveyAvailable(_ surveyAvailable: Bool) {
        DispatchQueue.main.async {
            self.surveyAvailable = surveyAvailable
        }
    }
}
```

#### ContentView Structure:
```swift
import SwiftUI
import TheoremReachSDK

struct ContentView: View {
    @EnvironmentObject var appDelegate: AppDelegate

    var body: some View {
        ZStack {
            // Background color
            Color(hex: "#1B0C47")
                .ignoresSafeArea()

            VStack(spacing: 30) {
                // Logo
                Image("AppIcon")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .cornerRadius(20)

                // Title
                Text("TheoremReach Demo App")
                    .font(.title)
                    .foregroundColor(.white)

                // Survey button
                Button(action: launchTheoremReach) {
                    Text("Take Surveys!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: 200)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                // Survey availability indicator
                if appDelegate.surveyAvailable {
                    Text("Surveys Available")
                        .foregroundColor(.green)
                }
            }
        }
    }

    func launchTheoremReach() {
        // Get root view controller for presentation
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {

            // Launch TheoremReach SDK
            TheoremReach.getInstance().showRewardCenter(from: rootViewController)
        }
    }
}

// Helper extension for hex colors
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        let r = Double((hexNumber & 0xff0000) >> 16) / 255
        let g = Double((hexNumber & 0x00ff00) >> 8) / 255
        let b = Double(hexNumber & 0x0000ff) / 255

        self.init(red: r, green: g, blue: b)
    }
}
```

### 6. Git Repository Setup
**Action:** Setup version control

6.1. Git repository status:
   - ✅ Git repository already initialized at `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp/.git`
   - No additional initialization needed

6.2. Update `.gitignore`:
   - Same as Phase 1 (exclude user-specific Xcode files)

6.3. Initial commit (after migration complete):
   ```bash
   cd /Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp
   git add .
   git commit -m "Initial commit: SwiftUI version of TheoremReach iOS SDK example app

   - Implemented SwiftUI UI architecture
   - Integrated TheoremReach SDK using UIApplicationDelegateAdaptor
   - Created AppDelegate for SDK lifecycle management
   - Built ContentView with SwiftUI Button for survey launch
   - Added TheoremReachSDK and PlaytimeMonetize frameworks
   - Configured all required system frameworks
   "
   ```

## Key Differences: SwiftUI vs Storyboard

### Architecture Changes:
- **App Entry:** `@main struct App` instead of `@main class AppDelegate`
- **Delegates:** `@UIApplicationDelegateAdaptor` to use AppDelegate in SwiftUI
- **UI:** SwiftUI Views instead of UIViewControllers
- **Navigation:** No Storyboards, segues, or IBActions
- **Layout:** Declarative SwiftUI layout (VStack/HStack) instead of Interface Builder
- **State:** `@Published`, `@EnvironmentObject`, `@State` for reactive updates

### SDK Integration Adaptations:
- **Initialization:** Same SDK setup in AppDelegate
- **Delegates:** Same delegate protocols, published properties for SwiftUI reactivity
- **Presentation:** Must get UIViewController from WindowScene for SDK presentation
- **Lifecycle:** Use SwiftUI lifecycle modifiers instead of UIViewController lifecycle

### Files Structure Comparison:
**Phase 1 (Storyboard):**
- `AppDelegate.swift` (UIApplicationDelegate, window management)
- `ViewController.swift` (UIViewController)
- `Main.storyboard` (Interface Builder)
- `LaunchScreen.storyboard`

**Phase 2 (SwiftUI):**
- `TheoremReachiOSExampleAppApp.swift` (App protocol entry)
- `AppDelegate.swift` (UIApplicationDelegate via adaptor)
- `ContentView.swift` (SwiftUI View)
- No storyboards

## Verification Steps (Phase 2)

### Build Verification:
1. Open `/Users/andykeller/Code/iOS-Apps/iOSSDK-Swift-SwiftUI/TheoremReachiOSExampleApp/TheoremReachiOSExampleApp.xcodeproj` in Xcode
2. Select a simulator target (iPhone 15 Pro or newer for best SwiftUI experience)
3. Build project (⌘B) - should compile without errors
4. Verify frameworks are properly embedded
5. Check for Swift/SwiftUI compilation warnings

### Runtime Verification:
1. Run app in simulator
2. Verify SwiftUI interface renders correctly
3. Test "Take Surveys!" button launches TheoremReach SDK
4. Verify IDFA permission prompt appears (on first launch)
5. Verify TheoremReach SDK initializes (check console logs)
6. Confirm TheoremReach reward center opens
7. Test delegate callbacks update SwiftUI state:
   - Survey availability indicator updates
   - Reward notifications work
8. Test app rotation/orientation changes

### SwiftUI-Specific Verification:
1. Verify SwiftUI previews work (if implemented)
2. Check state management (@Published properties update UI)
3. Verify environment object injection works
4. Test UIKit-SwiftUI bridge for SDK presentation
5. Verify color/styling matches original app design

## Execution Order (Phase 2 - SwiftUI):
1. ✅ **COMPLETED:** Create new SwiftUI Xcode project
2. **Next:** Copy frameworks to project directory
3. **User:** Drag frameworks into Xcode and set to "Embed & Sign"
4. **Agent:** Copy assets and resources
5. **Agent:** Create AppDelegate.swift for SDK integration
6. **Agent:** Update App file with UIApplicationDelegateAdaptor
7. **Agent:** Create ContentView with SwiftUI UI
8. **User/Agent:** Configure build settings and link system frameworks
9. **Agent:** Test SDK integration and fix any issues
10. **Agent:** Create initial commit
11. **User + Agent:** Build and verify together

## Notes (Phase 2)

### SwiftUI Considerations:
1. **SDK Presentation:** TheoremReach SDK likely returns UIViewController. Must present from root UIViewController obtained from WindowScene.

2. **App Lifecycle:** SwiftUI app lifecycle differs from UIKit. Use `@UIApplicationDelegateAdaptor` to preserve SDK initialization in AppDelegate.

3. **State Management:** Use `@Published` properties in AppDelegate and `@EnvironmentObject` to make SDK state available to SwiftUI views.

4. **iOS Version:** SwiftUI works best on iOS 15+. Consider raising deployment target if targeting modern SwiftUI features.

5. **Preview Support:** SwiftUI previews may not work with SDK integration. Use runtime testing in simulator.

### Migration Strategy:
1. **Reference Phase 1:** Use completed Storyboard migration as reference for SDK integration logic
2. **UI Rewrite:** Don't try to convert Storyboard to SwiftUI 1:1. Design fresh SwiftUI interface
3. **Test Incrementally:** Build and test after each major component (AppDelegate → App file → ContentView)
4. **UIKit Bridge:** Be prepared to use `UIViewControllerRepresentable` if SDK requires deep UIKit integration
