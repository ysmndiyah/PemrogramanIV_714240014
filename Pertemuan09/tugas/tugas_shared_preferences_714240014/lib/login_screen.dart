import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_714240014/botnav.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  late SharedPreferences loginData;
  late bool newUser;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    loginData = await SharedPreferences.getInstance();
    newUser = loginData.getBool('login') ?? true;

    // Memuat status Remember Me dan mengisi TextField username otomatis
    bool isRemembered = loginData.getBool('remember_me') ?? false;
    String savedUsername = loginData.getString('saved_username') ?? '';

    setState(() {
      _rememberMe = isRemembered;
      if (isRemembered && savedUsername.isNotEmpty) {
        _usernameController.text = savedUsername;
      }
    });

    if (newUser == false) {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const DynamicBottomNavBar(),
        ),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value != null && value.length < 4) {
      return 'Masukkan minimal 4 karakter';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value != null && value.length < 3) {
      return 'Masukkan minimal 3 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Shared Preference'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _usernameController,
                      validator: _validateUsername,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.account_circle_rounded),
                        hintText: 'Write username here...',
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        fillColor: Color.fromARGB(255, 242, 254, 255),
                        filled: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      validator: _validatePassword,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password_rounded),
                        hintText: 'Write your password here...',
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        fillColor: Color.fromARGB(255, 242, 254, 255),
                        filled: true,
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    title: const Text('Remember Me'),
                    value: _rememberMe,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final isValidForm = _formKey.currentState!.validate();
                        String username = _usernameController.text;

                        if (isValidForm) {
                          loginData.setBool('login', false);
                          loginData.setString('username', username);

                          if (_rememberMe) {
                            loginData.setBool('remember_me', true);
                            loginData.setString('saved_username', username);
                          } else {
                            loginData.setBool('remember_me', false);
                            loginData.remove('saved_username');
                          }

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DynamicBottomNavBar(),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}