import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  DynamicLinkService._();

  static final DynamicLinkService instance = DynamicLinkService._();

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData? dynamicLink) async {
        final Uri deeplink = dynamicLink!.link;

        handleDynamicLink(deeplink);
      },
      onError: (OnLinkErrorException e) async {
        print("We got error $e");
      },
    );
  }

  void handleDynamicLink(Uri deepLink) {
    print('handleDeepLink | deeplink: $deepLink');

    // Check if we want to make a post
    // post is action
    final isPost = deepLink.pathSegments.contains('post');

    if (isPost) {
      // get the title of the post
      // title is a query parameter
      //action?parameter=
      final String? title = deepLink.queryParameters['title'];
      if (title != null) {
        print(title);
      }
    }
  }

  Future<String> buildDynamicLinks(String title) async {
    const String url = "https://bloctemplate.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/post?title=$title'),
      androidParameters: AndroidParameters(
        packageName: "com.example.bloctemplate.bloctemplate",
        minimumVersion: 0,
      ),
      // iosParameters: IosParameters(
      //   bundleId: "Bundle-ID",
      //   minimumVersion: '0',
      // ),
    );
    final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();

    final String desc = dynamicUrl.shortUrl.toString();
    print(desc);

    return desc;
  }
}
