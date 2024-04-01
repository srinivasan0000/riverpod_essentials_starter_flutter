import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension Catching<T> on AutoDisposeRef<T> {
  void cacheFor(Duration duration) {
    final link = keepAlive();
    Timer timer = Timer(duration, link.close);
    onDispose(() {
      timer.cancel();
      link.close();
    });
  }

  void disposeDelay(Duration duration) {
    final link = keepAlive();
    Timer? timer;

    onCancel(() {
      timer = Timer(duration, link.close);
    });

    onDispose(() {
      timer?.cancel();
    });

    onResume(() {
      timer?.cancel();
    });
  }

  void keepAliveUntilNoListeners() {
    keepAlive();
    onCancel(invalidateSelf);
  }
}

extension WidgetRefExtension on WidgetRef {
  bool isLoading<T>(ProviderListenable<AsyncValue<T>> provider) {
    return watch(provider.select((AsyncValue<T> s) => s.isLoading));
  }

  void easyListen<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    bool handleLoading = true,
    bool handleError = true,
    void Function(T data)? whenData,
  }) {
    return listen(
      provider,
      (prevState, newState) {
        prevState?.whenOrNull(
          skipLoadingOnRefresh: false,
          loading: handleLoading ? () => debugPrint("Your Navigation Logic") : null,
        );
        newState.whenOrNull(
          skipLoadingOnRefresh: false,
          loading: handleLoading ? () => debugPrint("Your dialog Logic") : null,
          error: handleError ? (err, st) => debugPrint("Your dialog Logic") : null,
          data: whenData,
        );
      },
    );
  }
}
