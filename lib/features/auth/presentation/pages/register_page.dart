import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/localization/app_strings.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        RegisterSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          username: _usernameController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    context.tr('register_title'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    context.tr('register_subtitle'),
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: AppColors.gray500),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            labelText: context.tr('first_name'),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr('field_required');
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            labelText: context.tr('last_name'),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return context.tr('field_required');
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: context.tr('username'),
                      prefixIcon: const Icon(Icons.alternate_email),
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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: context.tr('email'),
                      hintText: "name@example.com",
                      prefixIcon: const Icon(Icons.email_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.tr('field_required');
                      }
                      if (!value.contains('@')) {
                        return context.tr('invalid_email');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // حقل كلمة المرور
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
                      if (value.length < 6) {
                        return context.tr('password_too_short');
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // حقل تأكيد كلمة المرور
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _isConfirmPasswordHidden,
                    decoration: InputDecoration(
                      labelText: context.tr('confirm_password'),
                      prefixIcon: const Icon(Icons.lock_reset_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.gray500,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordHidden =
                                !_isConfirmPasswordHidden;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return context.tr('passwords_dont_match');
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
                            content: Text(context.tr('register_success')),
                          ),
                        );
                        context.go(AppRoutes.products);
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
                              : _onRegisterPressed,
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
                                  context.tr('register_button'),
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
                      Text(context.tr('already_have_account')),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          context.tr('login_button'),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
