import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "Signup",
      theme: ThemeData(fontFamily: 'Schyler'),
      home: const Scaffold(
        body: myProfileScreen(),
      ),
      // appBar: AppBar(
      //   title: const Text('Second Route'),
      // ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //
      //       // Navigate back to first route when tapped.
      //     },
      //     child: const Text('Go back!'),
      //   ),
      // ),
    );
  }
}

class myProfileScreen extends StatefulWidget {
  const myProfileScreen({Key? key}) : super(key: key);

  @override
  State<myProfileScreen> createState() => Myscreenui();
}

Future<http.Response> createUser() {
  return http.post(
    Uri.parse('https://speedp.live/snak4ev/GetCustomerV1.2/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'customerid': "1",
    }),
  );
}

var infos;
var mobilenumber="";
var emailid="";
var address="";
var countryid="";
var stateid="";
var cityid="";
var first_name="";
var last_name="";
var postal_code="";
var gstin="";



class Myscreenui extends State<myProfileScreen> {
  bool agree = false;
  void initState() {
    super.initState();
    checkOTP();

  }


  @override
  Widget build(BuildContext context) {
    // ShowLoading(context);

    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                child: const Text(
                  'MY PROFILE',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                )),
            Container(
              height: 120,
              width: 120,
              alignment: Alignment.center,
              // padding: const EdgeInsets.all(10),
              child: Image.asset('images/logoround.png'),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                first_name ?? 'default value',
                style: TextStyle(fontSize: 22, color: Colors.red.shade900),
              ),
            ),
            Form(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,

                    // margin: const EdgeInsets.all(15.0),
                    // padding: const EdgeInsets.all(3.0),
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.blueAccent)
                    // ),
                    child: Text('Mobile Number',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,

                    // margin: const EdgeInsets.all(15.0),
                    // padding: const EdgeInsets.all(3.0),
                    // decoration: BoxDecoration(
                    //     border: Border.all(color: Colors.blueAccent)
                    // ),
                    child: Text(mobilenumber ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Email',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(emailid ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('GSTIN',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(gstin ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Address',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(address ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('City',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(cityid ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('State',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(stateid ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Country',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(countryid ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text('Postal Code',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(postal_code ?? 'default value',
                        style: const TextStyle(
                            fontSize: 18, color: Colors.grey)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileEditScreen()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  )),
            ),
          ],
        ));
  }

  void checkOTP() async {
    http.Response response = await createUser();

    print(response.body);
    infos = json.decode(response.body);
    print(infos['status']);
    if (infos['status'].toString() == 'success') {
      mobilenumber = infos['mobilenumber'];
      emailid = infos['emailid'];
      address = infos['address'];
      countryid = infos['countryid'];
      stateid = infos['stateid'];
      cityid = infos['cityid'];
      first_name = infos['first_name'];
      last_name = infos['last_name'];
      postal_code = infos['postal_code'];
      gstin = infos['gstin'];
    }


    else {
      print("Raja");
    }
    setState(() {});
    // if (this.mounted) { // check whether the state object is in tree
    //   setState(() {
    //     // make changes here
    //   });
    // }
  }
}

class ProfileEditScreen extends StatelessWidget {

  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Signup",
      theme: ThemeData(fontFamily: 'Schyler'),
      home: const Scaffold(
        body: ProfileEdit(),
      ),
      // appBar: AppBar(
      //   title: const Text('Second Route'),
      // ),
      // body: Center(
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //
      //       // Navigate back to first route when tapped.
      //     },
      //     child: const Text('Go back!'),
      //   ),
      // ),
    );
  }
}

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => MysignupScreenState();
}

class MysignupScreenState extends State<ProfileEdit> {
  TextEditingController nameController = TextEditingController();

  bool agree = false;
  final formkey = GlobalKey<FormState>();
  var Updatefirstname,
      Updatelastname,
      Updateemail,
      Updategstin,
      Updateaddress,
      Updatecountry,
      Updatestate,
      Updatecity,
      Updatepostalcode;

  var Validatefirstname,
      Validatelastname,
      Validateemail,
      Validategstin,
      Validateaddress,
      Validatecountry,
      Validateestate,
      Validatecity,
      Validatepostalcode;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                child: const Text(
                  'EDIT PROFILE',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                )),
            Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: TextEditingController(text: first_name),
                    validator: (Validatefirstname) {
                      if (Validatefirstname!.isEmpty) {
                        return "Please enter FirstName";
                      } else {
                        Updatefirstname = Validatefirstname;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'First Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: last_name),
                    validator: (Validatelastname) {
                      if (Validatelastname!.isEmpty) {
                        return "Please enter LastName";
                      } else {
                        Updatelastname = Validatelastname;
                      }
                    },
                    // controller: nameController,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'Last Name',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: emailid),
                    validator: (Validateemail) {
                      if (Validateemail!.isEmpty) {
                        return "Please enter Email";
                      } else {
                        Updateemail = Validateemail;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: gstin),
                    validator: (Validategstin) {
                      if (Validategstin!.isEmpty) {
                        return "Please enter GSTIN";
                      } else {
                        Updategstin = Validategstin;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'GSTIN',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: address),
                    validator: (Validateaddress) {
                      if (Validateaddress!.isEmpty) {
                        return "Please enter Street and Number";
                      } else {
                        Updateaddress = Validateaddress;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 1.1),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'Street and Number',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: countryid),
                    validator: (Validatecountry) {
                      if (Validatecountry!.isEmpty) {
                        return "Please enter Country";
                      } else {
                        Updatecountry = Validatecountry;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'Country',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: stateid),
                    validator: (Validateestate) {
                      if (Validateestate!.isEmpty) {
                        return "Please enter State";
                      } else {
                        Updatestate = Validateestate;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'State',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: cityid),
                    validator: (Validatecity) {
                      if (Validatecity!.isEmpty) {
                        return "Please enter City";
                      } else {
                        Updatecity = Validatecity;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'City',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: TextEditingController(text: postal_code),
                    validator: (Validatepostalcode) {
                      if (Validatepostalcode!.isEmpty) {
                        return "Please enter Postal Code";
                      } else {
                        Updatepostalcode = Validatepostalcode;
                      }
                    },
                    style: const TextStyle(
                        fontSize: 18, color: Colors.black, height: 0.8),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      fillColor: Color(0xFFEFF1F3),
                      filled: true,
                      hintText: 'Postal Code',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                  child: const Text('Update', style: TextStyle(fontSize: 18)),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      CustomerUpdate();
                      ShowLoading(context);
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Form not validated'),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  )),
            ),
          ],
        ));
  }

  Future<http.Response> CustomerUpdatepost() {
    return http.post(
      Uri.parse('https://speedp.live/snak4ev/CustomerUpdateV1.2/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'customerid': "1",
        'address': Updateaddress,
        'email': Updateemail,
        'country': Updatecountry,
        'state': Updatestate,
        'city': Updatecity,
        'firstname': Updatefirstname,
        'lastname': Updatelastname,
        'postalcode': Updatepostalcode,
        'mobileno': '8344662998',
        'gstin': Updategstin,
      }),
    );
  }

  var infos2;

  void CustomerUpdate() async {
    http.Response response = await CustomerUpdatepost();

    print(response.body);
    infos2 = json.decode(response.body);
    print(infos2['status']);
    print(infos2['message']);
    if (infos2['status'] == 'success') {
      print("Moovendhar");

      Navigator.of(context, rootNavigator: true).pop(context);
    } else {
      Navigator.pop(context);

      print("Raja");
    }
  }

}

ShowLoading(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
