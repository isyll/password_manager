import 'package:flutter/material.dart';
import 'package:password_manager/core/extensions/context_extension.dart';
import 'package:password_manager/core/http/apis/auth_api.dart';
import 'package:password_manager/models/auth/signin_credentials.dart';
import 'package:password_manager/models/auth/signin_response.dart';
import 'package:password_manager/pages/home/home_page.dart';
import 'package:password_manager/services/secure_storage.dart';

class SigninPage extends StatefulWidget {
  static const routeName = '/auth/signin';
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _credentials = SigninCredentials();
  final _formKey = GlobalKey<FormState>();
  final _errors = <String, String?>{};
  var _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(key: _formKey, child: _buildForm()),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 280,
          child: Text(
            context.l.sign_in_to_your_account,
            style: context.theme.textTheme.headlineLarge!
                .copyWith(fontWeight: FontWeight.w800),
          ),
        ),
        if (_errorMessage.isNotEmpty) const SizedBox(height: 12),
        if (_errorMessage.isNotEmpty)
          Text(
            _errorMessage,
            softWrap: true,
            style: TextStyle(color: context.theme.colorScheme.error),
          ),
        SizedBox(
          height: 38,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: context.l.email,
            errorText: _errors['email'],
          ),
          onSaved: (value) => _credentials.email = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.l.email_required;
            }
            return null;
          },
        ),
        const SizedBox(height: 28),
        TextFormField(
          keyboardType: TextInputType.visiblePassword,
          enableSuggestions: false,
          obscureText: true,
          decoration: InputDecoration(
            hintText: context.l.password,
            errorText: _errors['password'],
          ),
          onSaved: (value) => _credentials.password = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.l.password_required;
            }
            return null;
          },
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: _onSubmit,
            child: Text(context.l.signin.toUpperCase()),
          ),
        ),
      ],
    );
  }

  void _onSubmit() async {
    _formKey.currentState!.save();
    if (_credentials.isValid) {
      final response = await AuthApi.signin(_credentials);
      if (response.status) {
        final data = SigninResponse.fromMap(response.data!);
        await SecureStorage.saveTokens(data.accessToken, data.refreshToken);
        if (mounted) {
          context.toNamed(HomePage.routeName);
        }
      } else {
        setState(() {
          _errorMessage = response.message ?? '';
          if (response.errors != null) {
            _errors.addAll(response.errors!);
          } else {
            _errors.clear();
          }
        });
      }
    }
  }
}
