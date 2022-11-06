// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class RecipeBuyersModel extends Equatable {
  const RecipeBuyersModel({
    required this.id,
    required this.recipe_title,
    required this.category_id,
    required this.step,
    this.image,
  });

  final int id;
  final String recipe_title;
  final int category_id;
  final String step;
  final String? image;

  @override
  List<Object?> get props => [
    id,
    recipe_title,
    category_id,
    step,
    image,
  ];
}
