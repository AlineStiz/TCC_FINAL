import 'package:flutter/material.dart';
import 'package:projeto_tcc/controller/auth_service.dart';
import 'package:projeto_tcc/helpers/validators.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final userManager = Provider.of<AuthService>(context);
    return Scaffold(
      key: scaffoldKey,
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              child: Image.asset('assets/images/logo1.png'),
            )
          ],
        ),
      body: Center(
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.2),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 30,
              ),
              shrinkWrap: true,
              children: [
                TextFormField(
                  controller: emailController,
                  enabled: !userManager.isLoading,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: (email) {
                    return emailValid(email!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: passController,
                  enabled: !userManager.isLoading,
                  decoration: InputDecoration(
                    hintText: 'Senha',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscureText = !isObscureText;
                        });
                      },
                      icon: Icon(
                        isObscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  autocorrect: false,
                  obscureText: isObscureText,
                  validator: (pass) {
                    return passValid(pass!);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 44,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            userManager.login(
                              emailController.text,
                              passController.text,
                            );
                            Navigator.of(context)
                                .pushReplacementNamed('/home');
                          }
                        },
                        child: userManager.isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Entrar',
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Align(
                      child: GestureDetector(
                        child: const Text('Redefinir senha'),
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot');
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
