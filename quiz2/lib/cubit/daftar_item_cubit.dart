import 'package:quiz2/cubit/item_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class itemListCubit extends Cubit<ItemState> {
  itemListCubit() : super(ItemListLoading());

  Future<void> fetchData(String url, String token) async {
    emit(ItemListLoading());
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        // Success
        setFromJson(jsonDecode(response.body));
      } else {
        // Error
        emit(ItemListError('Failed to load items'));
      }
    } catch (e) {
      // Exception
      emit(ItemListError('Failed to load items: $e'));
    }
  }

  void setFromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    List<item> itemList = data
        .map((e) => item(
              id: e['id'],
              title: e['name'],
              description: e['type'],
              price: e['member_sejak'],
              img_name: e['omzet_bulan'],
            ))
        .toList();
    emit(ItemListLoaded(items: itemList));
  }
}