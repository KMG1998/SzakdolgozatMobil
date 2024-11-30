/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $LibGen {
  const $LibGen();

  /// Directory path: lib/assets
  $LibAssetsGen get assets => const $LibAssetsGen();
}

class $LibAssetsGen {
  const $LibAssetsGen();

  /// Directory path: lib/assets/fonts
  $LibAssetsFontsGen get fonts => const $LibAssetsFontsGen();

  /// Directory path: lib/assets/images
  $LibAssetsImagesGen get images => const $LibAssetsImagesGen();
}

class $LibAssetsFontsGen {
  const $LibAssetsFontsGen();

  /// File path: lib/assets/fonts/JetBrainsMonoRomanRegular.ttf
  String get jetBrainsMonoRomanRegular =>
      'lib/assets/fonts/JetBrainsMonoRomanRegular.ttf';

  /// List of all assets
  List<String> get values => [jetBrainsMonoRomanRegular];
}

class $LibAssetsImagesGen {
  const $LibAssetsImagesGen();

  /// File path: lib/assets/images/img_arrow_down.svg
  SvgGenImage get imgArrowDown =>
      const SvgGenImage('lib/assets/images/img_arrow_down.svg');

  /// File path: lib/assets/images/img_arrow_down_black_900.svg
  SvgGenImage get imgArrowDownBlack900 =>
      const SvgGenImage('lib/assets/images/img_arrow_down_black_900.svg');

  /// File path: lib/assets/images/img_arrow_up.svg
  SvgGenImage get imgArrowUp =>
      const SvgGenImage('lib/assets/images/img_arrow_up.svg');

  /// File path: lib/assets/images/img_clock.svg
  SvgGenImage get imgClock =>
      const SvgGenImage('lib/assets/images/img_clock.svg');

  /// File path: lib/assets/images/img_home.svg
  SvgGenImage get imgHome =>
      const SvgGenImage('lib/assets/images/img_home.svg');

  /// File path: lib/assets/images/img_home_button.svg
  SvgGenImage get imgHomeButton =>
      const SvgGenImage('lib/assets/images/img_home_button.svg');

  /// File path: lib/assets/images/img_lock.svg
  SvgGenImage get imgLock =>
      const SvgGenImage('lib/assets/images/img_lock.svg');

  /// File path: lib/assets/images/img_magantaxi_logo_1.png
  AssetGenImage get imgMagantaxiLogo1 =>
      const AssetGenImage('lib/assets/images/img_magantaxi_logo_1.png');

  /// File path: lib/assets/images/img_response_buttons.svg
  SvgGenImage get imgResponseButtons =>
      const SvgGenImage('lib/assets/images/img_response_buttons.svg');

  /// File path: lib/assets/images/img_vector.svg
  SvgGenImage get imgVector =>
      const SvgGenImage('lib/assets/images/img_vector.svg');

  /// File path: lib/assets/images/new_ride_button.png
  AssetGenImage get newRideButton =>
      const AssetGenImage('lib/assets/images/new_ride_button.png');

  /// File path: lib/assets/images/profile_button.svg
  SvgGenImage get profileButton =>
      const SvgGenImage('lib/assets/images/profile_button.svg');

  /// List of all assets
  List<dynamic> get values => [
        imgArrowDown,
        imgArrowDownBlack900,
        imgArrowUp,
        imgClock,
        imgHome,
        imgHomeButton,
        imgLock,
        imgMagantaxiLogo1,
        imgResponseButtons,
        imgVector,
        newRideButton,
        profileButton
      ];
}

class Assets {
  Assets._();

  static const $LibGen lib = $LibGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
