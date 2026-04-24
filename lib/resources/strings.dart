

class AppStrings {
  static final AppStrings _appStrings = AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  String get phoneNumberUserNameOrEmail => "Phone number, username, or email";
  String get addABrand => 'Add a Brand.';
  String get instagram => 'Instagram';
  String get or => 'OR';
  String get addAComment => 'Add a comment...';
  String get addToYourStory => 'Add to your story';
  String get chooseFromGallary => 'Choose from Gallery';
  String get password => 'Password';
  String get forgetPassword => "Forget Password?";
  String get logIn => "Log In";
  String get logInWithFacebook => "Log in with Facebook";
  String get signUp => "Sign up";
  String get donHaveAn => "Don't have an account?";
    String get stories => "Stories";
  String get noStories => "No Stories";

  String get suggestedForYou => "Suggested for you";
  String get seeAll => "See All";
  String get follow => "Follow";
  String get popular => "Popular";
  String get sponsored => "Sponsored";
  String get yourStory => "Your Story";

  String get permissionRequired => "Permission required";
  String get recent => "Recent";
  String get post => "Post";
  String get notificationsScreen => "Notification Screen";
  String get notifications => "Notifications";
  String get newPost => "New Post";

  String get posts => "Posts";
  String get followers => "Followers";
  String get following => "Following";
  String get userName => "User Name";
  String get profileDescription => "Flutter Developer | Tech Enthusiast";
  String get portfolioLink => "www.myportfolio.com";
  String get editProfile => "Edit Profile";
  String get shareProfile => "Share Profile";
  String get highlightNew => "New";
  String get highlightWork => "Work";
  String get highlightTrips => "Trips";
  String get highlightFavs => "Favs";
  String get noPostsYet => "No posts yet";
  String get reelsVideos => "Reels / Videos";
  String get taggedPosts => "Tagged Posts";
  String get defaultProfileTitle => "User_Name01";
  String get searchWithMetaAI => "Search with Meta AI";


}

AppStrings appStrings = AppStrings();
