import 'package:apiflutter/user_pet.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiHome extends StatefulWidget {
  const ApiHome({Key? key}) : super(key: key);

  @override
  State<ApiHome> createState() => _ApiHomeState();
}

class _ApiHomeState extends State<ApiHome> {
  late UserPets userPets;
  bool isDataLoded = false;
  String errorMsg = '';

  Future<UserPets> getDataFromAPI() async {
    Uri uri = Uri.parse(
        'https://jatinderji.github.io/users_pets_api/users_pets.json');
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      UserPets userPets = userPetsFromJson(response.body);
      print(userPets);
      setState(() {
        isDataLoded = true;
      });
      return userPets;
    } else {
      errorMsg = '${response.statusCode}: ${response.statusCode}';
      return UserPets(data: []);
    }
  }

  assignData() async {
    userPets = await getDataFromAPI();
  }

  @override
  void initState() {
    assignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API CALL'),
        centerTitle: true,
        shadowColor: Colors.deepPurple.shade100,
      ),
      body: isDataLoded
          ? errorMsg.isNotEmpty
              ? Text(errorMsg)
              : userPets.data.isEmpty
                  ? const Text('No Data')
                  : ListView.builder(
                      itemCount: userPets.data.length,
                      itemBuilder: (context, index) => getRow(index),
                    )
          : const Center(
              child: const CircularProgressIndicator(),
            ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 21,
          backgroundColor:
              userPets.data[index].isFrindly ? Colors.green : Colors.red,
          child: CircleAvatar(
            radius: 20,
            backgroundColor:
                userPets.data[index].isFrindly ? Colors.green : Colors.red,
            backgroundImage: NetworkImage(userPets.data[index].petImage),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              userPets.data[index].userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Dog: ${userPets.data[index].userName}'),
          ],
        ),
        trailing: Icon(
          userPets.data[index].isFrindly ? Icons.pets : Icons.do_not_touch,
          color: userPets.data[index].isFrindly ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
