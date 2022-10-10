class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();

  factory AppStrings() {
    return _appStrings;
  }

  AppStrings._internal();

  static const String appName = "Retail Academy";
  static const String userData = "USER_DATA";

  static String pointConstant = '00';
  static const String orgId = '6c05d04b-b14f-42a1-ace5-075189d7612a';

  // application fonts
  static const String robotoFont = "Roboto";
  static const String quizDataBaseName = "RETAIL_ACADEMY_QUIZ";

  static const String checkYourInternetConnectivity =
      "Check your internet connectivity";
  static const String error = "Error";
  static const String success = "Success";
  static const String userName = "User name";
  static const String password = "Password";
  static const String login = "Login";
  static const String forgotPassword = "Forgot password?";
  static const String help = "Help";
  static const String usernameIsRequired = "Username is required";
  static const String passwordIsRequired = "Password is required";
  static const String emailIsRequired = "Email is required";
  static const String valueIsRequired = "Value must not empty";
  static const String provideValidEmail = "Please provide valid email address";
  static const String home = "Home";
  static const String knowledge = "Knowledge";
  static const String retailReels = "Reels"; //Retail
  static const String infoSessions = "Sessions"; //Info
  static const String profile = "Profile";
  static const String points = "Points";
  static const String trending = "Trending";
  static const String search = "Search";
  static const String staffName = "Staff Name";
  static const String storeName = "Store Name";
  static const String staffIdNumber = "Staff ID Number";
  static const String emailAddress = "Email Address";
  static const String typeHere = "Type here...";
  static const String needToEditProfile = "Need to edit profile?";
  static const String contactRetailTeam = " Contact retail team.";
  static const String logout = "Log out";
  static const String notification = "Notification";
  static const String nextSession = "Next Session:";

  static const String funFacts = "Fun Facts";
  static const String masterClass = "Master Class";
  static const String quizMaster = "Quiz Master";
  static const String whatsHotBlog = "What's Hot Blog";
  static const String podCast = "Podcast";

  static const String funFactsDescription =
      "Brand/Product Flyer and Cheat Sheets";
  static const String masterClassDescription = "Brand/Product Master Class";
  static const String quizMasterDescription = "Master Class Quizs";
  static const String whatsHotBlogDescription = "Blogs";
  static const String podCastDescription = "Health and Wellness Podcasts";

  static const String submit = "Submit";
  static const String send = "Send";
  static const String cancel = "Cancel";
  static const String pickImageFromGallery = "Pick image from gallery";
  static const String pickImageFromCamera = "Pick image from camera";
  static const String imageCancelByUser = "Image cancel by user";
  static const String alert = "Alert";
  static const String ok = "OK";
  static const String quizAlreadyAttempted = " quiz already attempted.";
  static const String doYouWantToCancel = "Do you want to cancel?";
  static const String pdfError = "File not in PDF format or corrupted.";
  static const String tapToReload = "Tap to reload";
  static const String commentMustNotBeEmpty = "Comment must not be empty";
  static const String noCommentFound = "No comments found";
  static const String moreReadText = "more";
  static const String lessReadText = "less";
  static const String pleaseSelectYourAnswer = "Please select your answer.";
  static const String yourAnswerIsCorrect =
      "[Staff App] your answer is correct.";
  static const String incorrectAnswer =
      "[Staff App] your answer is incorrect. The correct answer is: ";
  static const String finalScore = "Your final score is :- ";
  static const String thanksForAttemptThisQuiz =
      "[Staff App] Thanks for attempting this Quiz.";
}
