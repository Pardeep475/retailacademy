package application.raybiztech.retailacademy

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import us.zoom.sdk.*

class MainActivity : FlutterActivity() {
    private val ZOOM_INTEGRATION_CHANNEL = "application.raybiztech.retailacademy/ZOOM_INTEGRATION"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        initializeSdk()
        println("METHOD_CHANNEL_PARAMS:- initializeSdk")
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ZOOM_INTEGRATION_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "JOIN_MEETING") {
                val userName = call.argument<String>("USER_NAME")
                val meetingId = call.argument<String>("MEETING_ID")
                val meetingPassword = call.argument<String>("MEETING_PASSWORD")

                println("METHOD_CHANNEL_PARAMS:- USER_NAME $userName")
                println("METHOD_CHANNEL_PARAMS:- MEETING_ID $meetingId")
                println("METHOD_CHANNEL_PARAMS:- MEETING_PASSWORD $meetingPassword")

                if (userName != null && meetingId != null && meetingPassword != null) {
                    joinMeeting(
                        userName = userName,
                        meetingId = meetingId,
                        meetingPassword = meetingPassword
                    )
                }

            } else {
                result.notImplemented()
            }
        }
    }

    private fun initializeSdk() {
        val sdk = ZoomSDK.getInstance()

        // TODO: Do not use hard-coded values for your key/secret in your app in production!
        val params = ZoomSDKInitParams().apply {
            appKey =
                "HIMamIALS7Xj2at8j5RcveUGDWvtlmhXyRzR" // TODO: Retrieve your SDK key and enter it here
            appSecret =
                "VYQ0baZxhNE7GtxfbgDM3KLX1jemNtpVL1kq" // TODO: Retrieve your SDK secret and enter it here
            domain = "zoom.us"
            enableLog = true // Optional: enable logging for debugging
        }
        // TODO (optional): Add functionality to this listener (e.g. logs for debugging)
        val listener = object : ZoomSDKInitializeListener {
            /**
             * If the [errorCode] is [ZoomError.ZOOM_ERROR_SUCCESS], the SDK was initialized and can
             * now be used to join/start a meeting.
             */
            override fun onZoomSDKInitializeResult(errorCode: Int, internalErrorCode: Int) = Unit
            override fun onZoomAuthIdentityExpired() = Unit
        }

        sdk.initialize(this@MainActivity, listener, params)
    }

    private fun joinMeeting(userName: String, meetingId: String, meetingPassword: String) {
        val meetingService = ZoomSDK.getInstance().meetingService
        val options = JoinMeetingOptions()
        val params = JoinMeetingParams().apply {
            displayName = userName
            meetingNo = meetingId
            password = meetingPassword
        }
        meetingService.joinMeetingWithParams(this@MainActivity, params, options)
    }
}
