import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/apod_controller.dart';
import 'data/apod_data_page.dart';
import 'error/apod_error.dart';
import 'loader/apod_loader.dart';

class ApodPage extends ConsumerWidget {
  const ApodPage({this.apodDate, super.key});

  final DateTime? apodDate;

  DateTime get _apodDate => apodDate ?? DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apodState = ref.watch(apodControllerProvider);

    return Scaffold(
      body: apodState.when(
        data: ((data) => ApodDataPage(apod: data)),
        error: (_, __) => ApodError(apodDate: _apodDate),
        loading: () => ApodLoader(apodDate: _apodDate),
      ),
    );
  }
}
