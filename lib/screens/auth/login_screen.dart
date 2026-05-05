import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../common/widgets/primary_button.dart';
import '../../common/widgets/social_login_button.dart';
import '../../controller/login_controller.dart';
import '../../routes/app_routes.dart';
import '../../utils/preferences_helper.dart';
import '../../utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  bool isPasswordHidden = true;
  bool rememberMe = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedData();
  }

  Future<void> _loadRememberedData() async {
    final bool remembered = await PreferencesHelper.getRememberMe();
    final String? savedEmail = await PreferencesHelper.getSavedEmail();
    if (!mounted) return;
    setState(() {
      rememberMe = remembered;
      if (remembered && savedEmail != null) {
        emailController.text = savedEmail;
      }
    });
  }

  Future<void> _submitLogin() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isLoading = true);
    try {
      await authController.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await PreferencesHelper.saveRememberMe(rememberMe, emailController.text.trim());
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
    } catch (e) {
      if (!mounted) return;
      final String raw = e.toString();
      if (raw.contains('EMAIL_NOT_VERIFIED')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email chưa xác minh. Hệ thống đã gửi lại email xác minh.'),
          ),
        );
        Navigator.pushNamed(
          context,
          AppRoutes.verifyEmail,
          arguments: emailController.text.trim(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(raw)));
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chào mừng trở lại',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) => Validators.validateEmail(value ?? ''),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  obscureText: isPasswordHidden,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () => setState(() {
                        isPasswordHidden = !isPasswordHidden;
                      }),
                    ),
                  ),
                  validator: (value) => Validators.validatePassword(value ?? ''),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (value) => setState(() => rememberMe = value ?? false),
                    ),
                    const Text('Remember me'),
                    const Spacer(),
                    TextButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.forgetPassword),
                      child: const Text('Quên mật khẩu?'),
                    ),
                  ],
                ),
                PrimaryButton(
                  title: isLoading ? 'Đang xử lý...' : 'Đăng nhập',
                  onPressed: isLoading ? () {} : _submitLogin,
                ),
                const SizedBox(height: 24),
                const Center(child: Text('OR')),
                const SizedBox(height: 16),
                SocialLoginButton(
                  icon: Icons.g_mobiledata,
                  title: 'Đăng nhập với Google',
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                SocialLoginButton(
                  icon: Icons.facebook,
                  title: 'Đăng nhập với Facebook',
                  onPressed: () {},
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Bạn chưa có tài khoản? '),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.register),
                      child: const Text(
                        'Đăng ký ngay',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
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
