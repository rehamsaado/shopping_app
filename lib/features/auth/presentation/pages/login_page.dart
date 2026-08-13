import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shopping_app/core/router/app_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 32),
                    Text(
                      context.tr('login_title'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.tr('welcome_back'),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 48),
                    TextFormField(
                      controller: _usernameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: context.tr('username'),
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return context.tr('field_required');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordHidden,
                      decoration: InputDecoration(
                        labelText: context.tr('password'),
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: AppColors.gray500,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordHidden = !_isPasswordHidden;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return context.tr('field_required');
                        }
                        if (value.length < 4) {
                          return context.tr('password_too_short');
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.tr('login_success')),
                            ),
                          );

                          // الانتقال الآمن باستخدام الـ userId القادم حصراً من الـ State والدلسة الديناميكية
                          context.go(AppRoutes.products, extra: state.user);
                        } else if (state is AuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(context.tr(state.message)),
                              backgroundColor: AppColors.error,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 55,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading
                                ? null
                                : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().add(
                                  LoginSubmitted(
                                    username: _usernameController.text
                                        .trim(),
                                    password: _passwordController.text
                                        .trim(),
                                  ),
                                );
                              }
                            },
                            child: state is AuthLoading
                                ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                                : Text(
                              context.tr('login_button'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(context.tr('dont_have_account')),
                        const SizedBox(width: 4),
                        TextButton(
                          onPressed: () {
                            context.push(AppRoutes.register);
                          },
                          child: Text(
                            context.tr('register_now'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}