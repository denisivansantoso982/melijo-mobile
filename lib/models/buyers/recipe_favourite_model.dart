// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class RecipeFavouriteModel extends Equatable {
  const RecipeFavouriteModel({
    required this.id,
    required this.user_customer_id,
    required this.recipe_id,
  });

  final int id;
  final int user_customer_id;
  final int recipe_id;

  @override
  List<Object?> get props => [
    id,
    user_customer_id,
    recipe_id,
  ];
}
