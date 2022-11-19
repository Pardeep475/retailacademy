import UIKit
import Flutter
import MobileRTC

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MobileRTCMeetingServiceDelegate {
    
    let sdkKey = "SIT5cR2lSchMAg1lvdx6bUfvx9JflLGDSGRM"
    let sdkSecret = "y7qEJ22BO9Zhs2XlPN6OP3Oty5xJGMHUmzWJ"

    var navigationController: UINavigationController!
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
           
          let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

      setupSDK(sdkKey: sdkKey, sdkSecret: sdkSecret)
      
          let methodChannel = FlutterMethodChannel(name: "application.raybiztech.retailacademy/ZOOM_INTEGRATION", binaryMessenger:controller.binaryMessenger)
        
          methodChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                  
            if call.method == "JOIN_MEETING" {
               
            // write zoom integration code here
                let args = call.arguments as! Dictionary<String, Any>
                print("METHOD_CHANNEL_PARAMS:-   ")
                let userName = args["USER_NAME"] as! String
                let meetingId = args["MEETING_ID"] as! String
                let meetingPassword = args["MEETING_PASSWORD"] as! String
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                       let mainVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                mainVC.userName = userName
                mainVC.meetingId = meetingId
                mainVC.meetingPassword = meetingPassword
               //        let mainVC = ConversationsViewController()
                       let navigationController = UINavigationController(rootViewController: mainVC)
                navigationController.title = "zoom call"
                       let controller:FlutterViewController = UIApplication.shared.keyWindow?.rootViewController as! FlutterViewController
                       navigationController.modalPresentationStyle = .fullScreen
                       controller.present(navigationController, animated: true, completion: nil)
                
                
                
                       self.window.makeKeyAndVisible()
                
            } else {
              result(FlutterMethodNotImplemented)
              return
            }
          })
      GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    // Logs the user out of the app upon application termination.
    // This is not a necessary action. In real use cases, the SDK should be alerted of app events. For example, in applicationWillTerminate(_ application: UIApplication), MobileRTC.shared().appWillTerminate should be called.
//    func applicationWillTerminate(_ application: UIApplication) {
//        // Obtain the MobileRTCAuthService from the Zoom SDK, this service can log in a Zoom user, log out a Zoom user, authorize the Zoom SDK etc.
//        if let authorizationService = MobileRTC.shared().getAuthService() {
//
//            // Call logoutRTC() to log the user out.
//            authorizationService.logoutRTC()
//
//            // Notify MobileRTC of appWillTerminate call.
//            MobileRTC.shared().appWillTerminate()
//        }
//    }
//
//    override func applicationWillResignActive(_ application: UIApplication) {
//        // Notify MobileRTC of appWillResignActive call.
//        MobileRTC.shared().appWillResignActive()
//    }
//
//    override func applicationDidBecomeActive(_ application: UIApplication) {
//        // Notify MobileRTC of appDidBecomeActive call.
//        MobileRTC.shared().appDidBecomeActive()
//    }
//
//    override func applicationDidEnterBackground(_ application: UIApplication) {
//        // Notify MobileRTC of appDidEnterBackgroud call.
//        MobileRTC.shared().appDidEnterBackgroud()
//    }

    /// Creates, Initializes, and Authorizes an instance of the Zoom SDK. This must be called before any other SDK functions.
    ///
    /// Assign a MobileRTCAuthDelegate to listen to SDK authorization events.
    ///
    /// In real applications, SDK Key's and SDK Secret's should not be used as they are highly sensitive data. A JWT should be used instead.
    /// Do not leave a JWT, SDK Key, or SDK Secret anywhere that is not secured.
    ///
    /// - Parameters:
    ///   - sdkKey: A valid SDK Client Key provided by the Zoom Marketplace.
    ///   - sdkSecret: A valid SDK Client Secret provided by the Zoom Marketplace.
    func setupSDK(sdkKey: String, sdkSecret: String) {
        // Create a MobileRTCSDKInitContext. This class contains attributes for modifying how the SDK will be created. You must supply the context with a domain.
        let context = MobileRTCSDKInitContext()
        // The domain we will use is zoom.us
        context.domain = "zoom.us"
        // Turns on SDK logging. This is optional.
        context.enableLog = true

        // Call initialize(_ context: MobileRTCSDKInitContext) to create an instance of the Zoom SDK. Without initializing first, the SDK will not do anything. This call will return true if the SDK was initialized successfully.
        let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)

        // Check if initialization was successful. Obtain a MobileRTCAuthService, this is for supplying credentials to the SDK for authorization.
        if sdkInitializedSuccessfully == true, let authorizationService = MobileRTC.shared().getAuthService() {

            // Supply the SDK with SDK Key and SDK Secret. This is required if a JWT is not supplied.
            // To use a JWT, replace these lines with authorizationService.jwtToken = yourJWTToken.
            authorizationService.clientKey = sdkKey
            authorizationService.clientSecret = sdkSecret

            // Assign AppDelegate to be a MobileRTCAuthDelegate to listen for authorization callbacks.
            authorizationService.delegate = self

            // Call sdkAuth to perform authorization.
            authorizationService.sdkAuth()
        }
    }
 
    
}




// MARK: - MobileRTCAuthDelegate

// Conform AppDelegate to MobileRTCAuthDelegate.
// MobileRTCAuthDelegate listens to authorization events like SDK authorization, user login, etc.
extension AppDelegate: MobileRTCAuthDelegate {

    // Result of calling sdkAuth(). MobileRTCAuthError_Success represents a successful authorization.
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        switch returnValue {
        case .success:
            print("SDK successfully initialized.")
        case .keyOrSecretEmpty:
            assertionFailure("SDK Key/Secret was not provided. Replace sdkKey and sdkSecret at the top of this file with your SDK Key/Secret.")
        case .keyOrSecretWrong, .unknown:
            assertionFailure("SDK Key/Secret is not valid.")
        default:
            assertionFailure("SDK Authorization failed with MobileRTCAuthError: \(returnValue).")
        }
    }
    
    // Result of calling logIn()
    func onMobileRTCLoginResult(_ resultValue: MobileRTCLoginFailReason) {
        switch resultValue {
        case .success:
            print("Successfully logged in")

            // This alerts the ViewController that log in was successful.
            NotificationCenter.default.post(name: Notification.Name("userLoggedIn"), object: nil)
        case .wrongPassword:
            print("Password incorrect")
        default:
            print("Could not log in. Error code: \(resultValue)")

        }
    }

    // Result of calling logoutRTC(). 0 represents a successful log out attempt.
    func onMobileRTCLogoutReturn(_ returnValue: Int) {
        switch returnValue {
        case 0:
            print("Successfully logged out")
        default:
            print("Could not log out. Error code: \(returnValue)")
        }
    }
}


