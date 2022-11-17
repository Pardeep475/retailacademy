import UIKit
import Flutter
import MobileRTC

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, MobileRTCMeetingServiceDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
           
          let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

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
                
                self.joinMeeting(userName: userName,meetingNumber: meetingId,meetingPassword:meetingPassword)
                
            } else {
              result(FlutterMethodNotImplemented)
              return
            }
          })
      GeneratedPluginRegistrant.register(with: self)
          return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func joinMeeting(userName : String, meetingNumber: String, meetingPassword: String) {
        // Obtain the MobileRTCMeetingService from the Zoom SDK, this service can start meetings, join meetings, leave meetings, etc.
        if let meetingService = MobileRTC.shared().getMeetingService() {

            // Set the ViewController to be the MobileRTCMeetingServiceDelegate
            meetingService.delegate = self

            // Create a MobileRTCMeetingJoinParam to provide the MobileRTCMeetingService with the necessary info to join a meeting.
            // In this case, we will only need to provide a meeting number and password.
            let joinMeetingParameters = MobileRTCMeetingJoinParam()
            joinMeetingParameters.userName = userName
            joinMeetingParameters.meetingNumber = meetingNumber
            joinMeetingParameters.password = meetingPassword

            
            print("METHOD_CHANNEL_PARAMS:-  JOIN Meeting ")
            // Call the joinMeeting function in MobileRTCMeetingService. The Zoom SDK will handle the UI for you, unless told otherwise.
            // If the meeting number and meeting password are valid, the user will be put into the meeting. A waiting room UI will be presented or the meeting UI will be presented.
            meetingService.joinMeeting(with: joinMeetingParameters)
        }
    }
    
}
