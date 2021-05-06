import 'dart:io';

import 'package:dio/dio.dart';

import '../model/user_model.dart';

abstract class IUserSerivce {
  final Dio dio;
  IUserSerivce(this.dio);
  final baseUrl = 'https://reqres.in/api';
  Future<List<Data>> fetchUserList();
}

class UserService extends IUserSerivce {
  UserService(Dio dio) : super(dio);

  final String _userPath = '/users?page=2';

  @override
  Future<List<Data>> fetchUserList() async {
    final response = await dio.get('$baseUrl$_userPath');

    if (response.statusCode == HttpStatus.ok) {
      final jsonItem = response.data;
      if (jsonItem is Map<String, dynamic>) {
        return UserModel.fromJson(jsonItem).data ?? [];
      }
    }

    return [];
  }
}
