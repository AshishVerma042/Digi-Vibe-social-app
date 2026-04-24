class AppImages {
  static get logo => 'assets/images/logo.png';
  static get metaIcon => 'assets/images/metaIcon.png';

  // Logo & Icons
  static const String instagramLogo = 'assets/images/Instagram_logo.svg';
  static const String commentIcon = 'assets/images/comment.svg';
  static const String messageIcon = 'assets/images/message.svg';
  static const String D_icon = 'assets/images/D_logo.png';

  // Posts
  static const String searchIcon = "assets/images/searchIcon.png";


  // Avatars
  static const String avatar1 = 'assets/images/avatar1.jpg';
  static const String avatar2 = 'assets/images/avatar2.jpg';
  static const String avatar3 = 'assets/images/avatar3.jpg';
  static const String avatarStatus = 'assets/images/avatarStatus.png';
  static const String aiGirl = 'assets/images/aiGirl.jpg';

  // Posts / Sample Images
  static const String car1 = 'assets/images/car1.jpg';
  static const String car2 = 'assets/images/car2.jpg';
  static const String car3 = 'assets/images/car3.jpg';

  static const String searchPost1 = 'assets/images/searchPost1.jpg';
  static const String searchPost2 = 'assets/images/searchPost2.jpg';
  static const String searchPost3 = 'assets/images/searchPost3.jpg';
  static const String searchPost4 = 'assets/images/searchPost4.jpg';
  static const String searchPost5 = 'assets/images/searchPost5.jpg';
  static const String searchPost6 = 'assets/images/searchPost6.jpg';
  static const String searchPost7 = 'assets/images/searchPost7.jpg';
  static const String searchPost8 = 'assets/images/searchPost8.jpg';




  AppImages appImages = AppImages();


  static final AppImages _appImages = AppImages._internal();
  factory AppImages() {
    return _appImages;
  }
  AppImages._internal();
}

AppImages appImages = AppImages();
