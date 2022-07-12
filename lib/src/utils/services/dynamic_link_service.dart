import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  DynamicLinkService._();

  static final DynamicLinkService instance = DynamicLinkService._();

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink;
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
      androidParameters: const AndroidParameters(
        packageName: "com.example.bloctemplate",
        minimumVersion: 0,
      ),
      // iosParameters: IosParameters(
      //   bundleId: "Bundle-ID",
      //   minimumVersion: '0',
      // ),
    );
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(parameters);

    final String desc = dynamicLink.toString();
    print(desc);

    return desc;
  }
}
