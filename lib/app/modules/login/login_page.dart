import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serial_communication_desktop/app/widgets/custom_button.dart';
import 'package:serial_communication_desktop/app/widgets/custom_input.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.find<LoginController>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'MASUK',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Silahkan masuk untuk melanjutkan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                children: [
                  CustomInput(
                    label: 'Username',
                    controller: _usernameController,
                    hint: 'Masukkan username Anda',
                    icon: Icons.person,
                  ),
                  const SizedBox(height: 16),
                  CustomInput(
                    label: 'Kata Sandi',
                    controller: _passwordController,
                    hint: 'Masukkan kata sandi Anda',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              text: 'MASUK',
                              onPressed: () {
                                controller.login(
                                  _usernameController.text,
                                  _passwordController.text,
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
