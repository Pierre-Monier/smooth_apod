import 'package:equatable/equatable.dart';

abstract class AppUser extends Equatable {
  const AppUser({required this.uid, required this.username});

  final String uid;
  final String username;

  @override
  List<Object?> get props => [uid, username];
}
