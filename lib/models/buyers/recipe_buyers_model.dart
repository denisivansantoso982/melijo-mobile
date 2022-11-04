// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class RecipeBuyersModel extends Equatable {
  const RecipeBuyersModel({
    required this.id,
    required this.recipe_title,
    required this.recipe_level,
    required this.step,
    this.image,
  });

  final int id;
  final String recipe_title;
  final String recipe_level;
  final String step;
  final String? image;

  @override
  List<Object?> get props => [
    id,
    recipe_title,
    recipe_level,
    step,
    image,
  ];
}
