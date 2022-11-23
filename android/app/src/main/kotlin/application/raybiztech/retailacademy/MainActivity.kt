package application.raybiztech.retailacademy

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import us.zoom.sdk.*

class MainActivity : FlutterActivity() {
    private val ZOOM_INTEGRATION_CHANNEL = "application.raybiztech.retailacademy/ZOOM_INTEGRATION"

    var userName: String = ""
    var userEmail: String = ""


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        initializeSdk()
        println("METHOD_CHANNEL_PARAMS:- initializeSdk")
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            ZOOM_INTEGRATION_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "JOIN_MEETING") {
                userName = call.argument<String>("USER_NAME").toString()
                userEmail = call.argument<String>("USER_EMAIL").toString()
                val meetingId = call.argument<String>("MEETING_ID")
                val meetingPassword = call.argument<String>("MEETING_PASSWORD")

                println("METHOD_CHANNEL_PARAMS:- USER_NAME $userName")
                println("METHOD_CHANNEL_PARAMS:- MEETING_ID $meetingId")
                println("METHOD_CHANNEL_PARAMS:- MEETING_PASSWORD $meetingPassword")

                if (meetingId != null && meetingPassword != null) {
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
                "SIT5cR2lSchMAg1lvdx6bUfvx9JflLGDSGRM" // TODO: Retrieve your SDK key and enter it here
            appSecret =
                "y7qEJ22BO9Zhs2XlPN6OP3Oty5xJGMHUmzWJ" // TODO: Retrieve your SDK secret and enter it here
            domain = "zoom.us"
            enableLog = true // Optional: enable logging for debugging
        }
        // TODO (optional): Add functionality to this listener (e.g. logs for debugging)
        val listener = object : ZoomSDKInitializeListener {
            /**
             * If the [errorCode] is [ZoomError.ZOOM_ERROR_SUCCESS], the SDK was initialized and can
             * now be used to join/start a meeting.
             */
            override fun onZoomSDKInitializeResult(errorCode: Int, internalErrorCode: Int) : Unit{

            }
            override fun onZoomAuthIdentityExpired() = Unit
        }

        sdk.initialize(this@MainActivity, listener, params)

    }

    private fun joinMeeting(
        userName: String,
        meetingId: String,
        meetingPassword: String,
    ) {
        val meetingService = ZoomSDK.getInstance().meetingService
        val options = JoinMeetingOptions()
        options.no_webinar_register_dialog = true
        val params = JoinMeetingParams().apply {
            displayName = userName
            meetingNo = meetingId
            password = meetingPassword
        }
        meetingService.joinMeetingWithParams(this@MainActivity, params, options)

        ZoomSDK.getInstance()?.inMeetingService?.addListener(meetingServiceListener)
    }


    private val meetingServiceListener = object : InMeetingServiceListener{
        override fun onMeetingNeedPasswordOrDisplayName(
            p0: Boolean,
            p1: Boolean,
            p2: InMeetingEventHandler?
        ) {
            p2?.setRegisterWebinarInfo(userName,userEmail,false)
        }

        override fun onWebinarNeedRegister(p0: String?) {
            println("METHOD_CHANNEL_PARAMS:- $p0")
        }

        override fun onJoinWebinarNeedUserNameAndEmail(p0: InMeetingEventHandler?) {
            p0?.setRegisterWebinarInfo(userName,userEmail,false)

        }

        override fun onMeetingNeedCloseOtherMeeting(p0: InMeetingEventHandler?) {
            
        }

        override fun onMeetingFail(p0: Int, p1: Int) {
            
        }

        override fun onMeetingLeaveComplete(p0: Long) {
            
        }

        override fun onMeetingUserJoin(p0: MutableList<Long>?) {
            
        }

        override fun onMeetingUserLeave(p0: MutableList<Long>?) {
            
        }

        override fun onMeetingUserUpdated(p0: Long) {
            
        }

        override fun onMeetingHostChanged(p0: Long) {
            
        }

        override fun onMeetingCoHostChanged(p0: Long) {
            
        }

        override fun onMeetingCoHostChange(p0: Long, p1: Boolean) {
            
        }

        override fun onActiveVideoUserChanged(p0: Long) {
            
        }

        override fun onActiveSpeakerVideoUserChanged(p0: Long) {
            
        }

        override fun onHostVideoOrderUpdated(p0: MutableList<Long>?) {
            
        }

        override fun onFollowHostVideoOrderChanged(p0: Boolean) {
            
        }

        override fun onSpotlightVideoChanged(p0: Boolean) {
            
        }

        override fun onSpotlightVideoChanged(p0: MutableList<Long>?) {
            
        }

        override fun onUserVideoStatusChanged(
            p0: Long,
            p1: InMeetingServiceListener.VideoStatus?
        ) {
            
        }

        override fun onUserNetworkQualityChanged(p0: Long) {
            
        }

        override fun onSinkMeetingVideoQualityChanged(p0: VideoQuality?, p1: Long) {
            
        }

        override fun onMicrophoneStatusError(p0: InMeetingAudioController.MobileRTCMicrophoneError?) {
            
        }

        override fun onUserAudioStatusChanged(
            p0: Long,
            p1: InMeetingServiceListener.AudioStatus?
        ) {
            
        }

        override fun onHostAskUnMute(p0: Long) {
            
        }

        override fun onHostAskStartVideo(p0: Long) {
            
        }

        override fun onUserAudioTypeChanged(p0: Long) {
            
        }

        override fun onMyAudioSourceTypeChanged(p0: Int) {
            
        }

        override fun onLowOrRaiseHandStatusChanged(p0: Long, p1: Boolean) {
            
        }

        override fun onChatMessageReceived(p0: InMeetingChatMessage?) {
            
        }

        override fun onChatMsgDeleteNotification(p0: String?, p1: ChatMessageDeleteType?) {
            
        }

        override fun onShareMeetingChatStatusChanged(p0: Boolean) {
            
        }

        override fun onSilentModeChanged(p0: Boolean) {
            
        }

        override fun onFreeMeetingReminder(p0: Boolean, p1: Boolean, p2: Boolean) {
            
        }

        override fun onMeetingActiveVideo(p0: Long) {
            
        }

        override fun onSinkAttendeeChatPriviledgeChanged(p0: Int) {
            
        }

        override fun onSinkAllowAttendeeChatNotification(p0: Int) {
            
        }

        override fun onSinkPanelistChatPrivilegeChanged(p0: InMeetingChatController.MobileRTCWebinarPanelistChatPrivilege?) {
            
        }

        override fun onUserNameChanged(p0: Long, p1: String?) {
            
        }

        override fun onUserNamesChanged(p0: MutableList<Long>?) {
            
        }

        override fun onFreeMeetingNeedToUpgrade(p0: FreeMeetingNeedUpgradeType?, p1: String?) {
            
        }

        override fun onFreeMeetingUpgradeToGiftFreeTrialStart() {
            
        }

        override fun onFreeMeetingUpgradeToGiftFreeTrialStop() {
            
        }

        override fun onFreeMeetingUpgradeToProMeeting() {
            
        }

        override fun onClosedCaptionReceived(p0: String?, p1: Long) {
            
        }

        override fun onRecordingStatus(p0: InMeetingServiceListener.RecordingStatus?) {
            
        }

        override fun onLocalRecordingStatus(
            p0: Long,
            p1: InMeetingServiceListener.RecordingStatus?
        ) {
            
        }

        override fun onInvalidReclaimHostkey() {
            
        }

        override fun onPermissionRequested(p0: Array<out String>?) {
            
        }

        override fun onAllHandsLowered() {
            
        }

        override fun onLocalVideoOrderUpdated(p0: MutableList<Long>?) {
            
        }

    }


}
