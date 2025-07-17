import 'package:get/get.dart';
import '../../services/api_service.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  var userData = {}.obs;   // Untuk menyimpan data user setelah login

  Future<void> login(String username, String password) async {
    isLoading.value = true;

    final result = await ApiService.login(username, password);

    if (result != null) {
      userData.value = result['user'];
      Get.snackbar('Login Berhasil', 'Selamat datang ${userData['name']}');
      Get.offAllNamed('/dashboard');  // Redirect ke dashboard
    } else {
      Get.snackbar('Login Gagal', 'Username atau password salah');
    }

    isLoading.value = false;
  }
}
