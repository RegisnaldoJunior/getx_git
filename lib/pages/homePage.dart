import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_firebase/controller/homeController.dart';
import 'package:login_firebase/data/repositories/github_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Homecontroller _controller;

  @override
  void initState() {
    super.initState();
    _controller = Homecontroller(
      repository: GithubRepository(
        dio: Dio(),
      ),
    );
    _controller.getGithubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Git Hub Users',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        return _controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : _controller.users.isEmpty
                ? Center(
                    child: Text('Nenhum usuário encontrado'),
                  )
                : ListView.builder(
                    itemCount: _controller.users.length,
                    itemBuilder: (_, index) {
                      final item = _controller.users[index];
                      return ListTile(
                        title: Text(item.login),
                      );
                    },
                  );
      },),
    );
  }
}
