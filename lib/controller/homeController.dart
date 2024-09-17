import 'package:get/get.dart';
import 'package:login_firebase/data/repositories/github_repository.dart';
import 'package:login_firebase/models/github_user_model.dart';

class Homecontroller extends GetxController{
  final GithubRepository repository;

  final List<GithubUserModel> _users = <GithubUserModel>[].obs;
  List<GithubUserModel> get users => _users;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  Homecontroller({required this.repository});

  getGithubUsers() async {
    _isLoading.value = true;

    final response = await repository.getGithubUsers();

    _users.addAll(response);

    _isLoading.value = false;
  }
}