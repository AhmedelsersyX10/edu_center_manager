import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:edu_center_manager/core/widgets/no_internet_widget.dart';
import 'package:flutter/material.dart';

/// Wraps any widget. Shows [NoInternetWidget] when offline and
/// automatically calls [onReconnected] as soon as the internet is back.
class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  /// Called when connectivity is restored. Use this to trigger a data refresh.
  final VoidCallback? onReconnected;

  /// Called when user taps "Retry" button while offline.
  final VoidCallback? onRetry;

  const ConnectivityWrapper({
    super.key,
    required this.child,
    this.onReconnected,
    this.onRetry,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  bool _isOnline = true;
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _subscription = Connectivity().onConnectivityChanged.listen(_onConnectivityChanged);
  }

  Future<void> _checkInitialConnectivity() async {
    final results = await Connectivity().checkConnectivity();
    final online = _hasConnection(results);
    if (mounted) setState(() => _isOnline = online);
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final online = _hasConnection(results);
    final wasOffline = !_isOnline;
    if (mounted) setState(() => _isOnline = online);

    // Auto-refresh when coming back online
    if (online && wasOffline) {
      widget.onReconnected?.call();
    }
  }

  bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isOnline) {
      return NoInternetWidget(
        onRetry: widget.onRetry ?? widget.onReconnected,
      );
    }
    return widget.child;
  }
}
