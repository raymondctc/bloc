import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  const User({
    @required this.name,
    @required this.id,
    @required this.gender
  });

  final String id;
  final String name;
  final int gender;

  @override
  List<Object> get props => [id, name, gender];

}