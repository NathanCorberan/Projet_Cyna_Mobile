import 'package:flutter/material.dart';
import '../widgets/header_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/VarProvider.dart';
import './login.dart';

class Accountparameter extends StatefulWidget  {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Accountparameter> {
  bool _changePassword = false;

  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  void _toggleChangePasswordMenu() {
    setState(() {
      _changePassword = !_changePassword;
    });
    print(_changePassword);
    _LoginState();
  }

  @override
  Widget build(BuildContext context) {
    final varProvider = Provider.of<VarProvider>(context);

    void logout() {
      varProvider.setUserVariableNull();
      _goToLogin(context);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderMenu(),
            SizedBox(height: 50),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF302082),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFFFFFFF),
                ),
                child:
                Column(
                  children: [
                    Text(
                      "Paramétre du compte",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                FontAwesomeIcons.solidUser,
                                color: Color(0xFF302082),
                                size: MediaQuery.of(context).size.width * 0.12,
                              ),
                            ),
                            Column(
                              children: [
                                _buildTextField("Nom",  varProvider.userVariable?.first_name ?? ""),
                                SizedBox(height: 10),
                                _buildTextField("Prénom", varProvider.userVariable?.last_name ?? "" ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 32,
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Color(0xFFF2F2F2),
                            border: Border.all(color: Color(0xFF302082), width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Email",
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                              Icon(Icons.email, color: Color(0xFF302082)),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child:
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFFFFFFFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                overlayColor: Colors.transparent,
                              ),
                              onPressed: _toggleChangePasswordMenu,
                              child: Text(
                                  "Change mot de passe",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ),
                        ),
                        if(!_changePassword)
                          Container(
                          child: Column(
                            children: [
                              Container(
                                height: 32,
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  border: Border.all(color: Color(0xFF302082), width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ancien mot de passe",
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                    Icon(Icons.email, color: Color(0xFF302082)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 32,
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  border: Border.all(color: Color(0xFF302082), width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Nouveau mot de passe",
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                    Icon(Icons.email, color: Color(0xFF302082)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 32,
                                width: MediaQuery.of(context).size.width * 0.7,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  border: Border.all(color: Color(0xFF302082), width: 2),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "COnfirmation mot de passe",
                                      style: TextStyle(color: Colors.black, fontSize: 16),
                                    ),
                                    Icon(Icons.email, color: Color(0xFF302082)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10),
                              TextButton(
                                onPressed: logout,
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF302082),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
                                ),
                                child: Text(
                                  "Déconnexion",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value, {bool obscureText = false}) {
    IconData icon;

    switch (label.toLowerCase()) {
      case "email":
        icon = Icons.email;
        break;
      case "nom":
      case "prénom":
        icon = Icons.person;
        break;
      case "mot de passe":
      case "confirmer mot de passe":
        icon = Icons.lock;
        break;
      default:
        icon = Icons.text_fields;
    }

    return Container(
      height: 32,
      width: MediaQuery.of(context).size.width * 0.45,
      margin: EdgeInsets.only(left: 15),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        border: Border.all(color: Color(0xFF302082), width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Icon(icon, color: Color(0xFF302082)),
        ],
      ),
    );

  }
}
