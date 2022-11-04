import 'dart:convert';

import 'package:aprokoblog/models/posts.dart';
import 'package:aprokoblog/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future fetchUser() async {
    final response = await http
        .get(fetchUserFunc("https://jsonplaceholder.typicode.com/posts"));

    List<Comment> posts = [];

    if (response.statusCode == 200) {
      var jsons = jsonDecode(response.body);

      for (var json in jsons) {
        Comment post = Comment.fromJson(json);
        posts.add(post);
      }
    } else {
      throw Exception('Failed to load user');
    }

    return posts;
  }

  late Future futureUser;
  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            "Messages",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),

            // width: 25,

            child: const Text(
              '5 New messages',
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  color: Colors.black),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 1000,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: FutureBuilder(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: ListTile(
                                leading: profileImage(
                                    "https://picsum.photos/250?image=9"),
                                title: textInfo(snapshot.data[index].user_id,
                                    FontWeight.w400, Colors.black),
                                // trailing: const Icon(
                                //   Icons.circle,
                                //   size: 15,
                                //   color: Colors.green,
                                // ),
                              ),
                            );
                          });
                    } else {
                      return loaderCircle();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
