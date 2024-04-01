import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  const ProviderLogger();

  @override
  void didAddProvider(ProviderBase<dynamic> provider, Object? value, ProviderContainer container) {
    TColorPrint.green("➕ DidAddProvider: ${provider.name ?? provider.runtimeType},");
    TColorPrint.green("=> value: $value");
  }

  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    TColorPrint.red("🗑️ DidDisposeProvider  : ${provider.name ?? provider.runtimeType}");
    super.didDisposeProvider(provider, container);
  }

  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    TColorPrint.green("🔄️ DidUpdateProvider: ${provider.name ?? provider.runtimeType},");
    TColorPrint.yellow("=> oldValue: $previousValue,");
    TColorPrint.yellow("=> newValue: $newValue");
  }
}

//you can any logger packages
class TColorPrint {
  TColorPrint._();
  static void yellow(String text) {
    debugPrint('\x1B[33m$text\x1B[0m');
  }

  static void red(String text) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }

  static void green(String text) {
    debugPrint('\x1B[92m$text\x1B[0m');
  }

  static void brightWhite(String text) {
    debugPrint('\x1B[97m$text\x1B[0m');
  }

  static void cyan(String text) {
    debugPrint('\x1B[36m$text\x1B[0m');
  }
}
