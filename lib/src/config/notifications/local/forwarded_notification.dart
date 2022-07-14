class ForwardedNotification {
  ForwardedNotification({
    this.title,
    this.delay = 0,
    this.body,
    required this.hasAccess,
    this.picture,
    required this.subtitle,
    required this.payload,
    required this.bigTitle,
    required this.summaryText,
    this.largeIconURL = 'https://via.placeholder.com/48x48',
    this.bigPictureFileName = 'bigPicture.jpg',
    this.largeIconFileName = 'largeIcon.jpg',
    this.bigPictureURL = 'https://via.placeholder.com/600x200',
  });

  final String? title;
  final int delay;
  final String? body;
  final bool hasAccess;
  final String? picture;
  final String subtitle;
  final String payload;
  final String bigTitle;
  final String summaryText;
  final String largeIconURL;
  final String bigPictureFileName;
  final String largeIconFileName;
  final String bigPictureURL;
}
