/// The Linux implementation of `share_plus`.
library share_plus_linux;

import 'dart:ui';

import 'package:cross_file/cross_file.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';
import 'package:url_launcher/url_launcher.dart';

/// The Linux implementation of SharePlatform.
class SharePlusLinuxPlugin extends SharePlatform {
  /// Register this dart class as the platform implementation for linux
  static void registerWith() {
    SharePlatform.instance = SharePlusLinuxPlugin();
  }

  /// Share text.
  /// Throws a [PlatformException] if `mailto:` scheme cannot be handled.
  @override
  Future<void> share(
    String text, {
    String? subject,
    Rect? sharePositionOrigin,
  }) async {
    final queryParameters = {
      if (subject != null) 'subject': subject,
      'body': text,
    };

    // see https://github.com/dart-lang/sdk/issues/43838#issuecomment-823551891
    final uri = Uri(
      scheme: 'mailto',
      query: queryParameters.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&'),
    );

    await launchUrl(uri);
  }

  /// Share files.
  @override
  Future<void> shareFiles(
    List<String> paths, {
    List<String>? mimeTypes,
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
  }) {
    throw UnimplementedError('shareFiles() has not been implemented on Linux.');
  }

  /// Share [XFile] objects with Result.
  @override
  Future<ShareResult> shareXFiles(
    List<XFile> files, {
    String? subject,
    String? text,
    Rect? sharePositionOrigin,
  }) {
    throw UnimplementedError(
      'shareXFiles() has not been implemented on Linux.',
    );
  }
}
