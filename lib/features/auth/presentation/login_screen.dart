import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../../dashboard/presentation/dashboard_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),

          child: Padding(
            padding: const EdgeInsets.all(24),

            child: Form(
              key: formKey,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Image.asset("assets/images/logo.png"),

                  const SizedBox(height: 20),

                  const Text(
                    'Cabinet Dr CHAFIQ HOUDA',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 40),

                  TextFormField(
                    controller: emailController,

                    keyboardType: TextInputType.emailAddress,

                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrer votre email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: passwordController,

                    obscureText: obscurePassword,

                    decoration: InputDecoration(
                      labelText: 'Mot de passe',

                      prefixIcon: const Icon(Icons.lock),

                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),

                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                      ),

                      border: const OutlineInputBorder(),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Entrer votre mot de passe';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 24),

                  if (authState.error != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),

                      child: Text(
                        authState.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  SizedBox(
                    width: double.infinity,

                    height: 52,

                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: authState.isLoading ? null : _login,

                      child: authState.isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(),
                            )
                          : const Text('CONNECTER'),
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

  Future<void> _login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final success = await ref
        .read(authControllerProvider.notifier)
        .login(
          email: emailController.text.trim(),

          password: passwordController.text,
        );

    if (!mounted) return;

    if (success) {
      // لاحقاً سيتم تحويل المستخدم
      // بواسطة GoRouter

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
  }
}
