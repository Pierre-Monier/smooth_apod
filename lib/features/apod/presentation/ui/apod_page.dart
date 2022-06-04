import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/data/repository/auth_repository.dart';

class ApodPage extends ConsumerWidget {
  const ApodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Apod Page'),
          ElevatedButton(
            onPressed: authRepository.signOut,
            child: const Text('Sign Out'),
          )
        ],
      ),
    );
  }
}
