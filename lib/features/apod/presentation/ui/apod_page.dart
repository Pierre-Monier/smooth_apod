import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/apod_controller.dart';

class ApodPage extends ConsumerWidget {
  const ApodPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apodState = ref.watch(apodControllerProvider);

    return Scaffold(
      body: apodState.when(
        data: ((data) => Center(
              child: Text(data.title),
            )),
        error: (_, __) => const Center(
          child: Text('Error'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
