import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'core/api_client.dart';
import 'data/repositories/alert_repository.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/product_repository.dart';
import 'data/repositories/watch_repository.dart';
import 'presentation/providers/alert_provider.dart';
import 'presentation/providers/auth_provider.dart';
import 'presentation/providers/watch_provider.dart';
import 'presentation/screens/alert_inbox_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/deal_feed_screen.dart';
import 'presentation/screens/product_detail_screen.dart';
import 'presentation/screens/watch_create_screen.dart';
import 'presentation/screens/watch_list_screen.dart';

class PriceTickerApp extends StatelessWidget {
  PriceTickerApp({super.key, ApiClient? api}) : _api = api ?? ApiClient();

  final ApiClient _api;
  late final _authRepo = AuthRepository(_api);
  late final _watchRepo = WatchRepository(_api);
  late final _alertRepo = AlertRepository(_api);
  late final _productRepo = ProductRepository(_api);

  late final _auth = AuthProvider(_authRepo, _api);

  late final _router = GoRouter(
    refreshListenable: _auth,
    initialLocation: '/login',
    redirect: (ctx, state) {
      if (!_auth.isAuthenticated) {
        return state.matchedLocation == '/login' ? null : '/login';
      }
      return state.matchedLocation == '/login' ? '/deals' : null;
    },
    routes: [
      GoRoute(
        path: '/deals',
        builder: (context, state) => const DealFeedScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/watches',
        builder: (context, state) => const WatchListScreen(),
      ),
      GoRoute(
        path: '/watches/create',
        builder: (context, state) => const WatchCreateScreen(),
      ),
      GoRoute(
        path: '/alerts',
        builder: (context, state) => const AlertInboxScreen(),
      ),
      GoRoute(
        path: '/products/:id',
        builder: (context, state) => ProductDetailScreen(
          productId: int.parse(state.pathParameters['id']!),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _api),
        ChangeNotifierProvider.value(value: _auth),
        ChangeNotifierProvider(create: (_) => WatchProvider(_watchRepo)),
        ChangeNotifierProvider(create: (_) => AlertProvider(_alertRepo)),
        Provider.value(value: _productRepo),
      ],
      child: MaterialApp.router(
        title: 'PriceTicker',
        routerConfig: _router,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF126B59)),
          scaffoldBackgroundColor: const Color(0xFFF5F7F4),
        ),
      ),
    );
  }
}
