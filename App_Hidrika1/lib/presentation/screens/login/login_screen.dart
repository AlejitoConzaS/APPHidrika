import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  static var name = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const BackgroundWidget(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: CustomCardContainerWidget(
                  child: Form(
                    key: _formKey,
                    child: _buildForm(context),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    VoidCallback? buttonAction;

    if (_isButtonEnabled) {
      buttonAction = () {
        if (_formKey.currentState!.validate()) {
          context.goNamed(ProductsScreen.name);
        }
      };
    } else {
      buttonAction = null;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const AvatarWidget(),
        const SizedBox(height: 16),
        const CustomTextWidget(
          text: 'Iniciar sesión',
          textType: TextType.title,
        ),
        const CustomTextWidget(
          text: 'Identifícate para ingresar',
          textType: TextType.subtitle,
        ),
        const SizedBox(height: 40),
        CustomInputFieldWidget(
          value: _userName,
          hintText: 'usuario',
          onChanged: (value) {
            _userName = value;
            _checkForm();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu usuario';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        CustomInputFieldWidget(
          value: _password,
          hintText: 'contraseña',
          obscureText: true,
          onChanged: (value) {
            _password = value;
            _checkForm();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu contraseña';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: 140,
          height: 45,
          child: CustomButtonWidget(
            text: 'Accede',
            type: ButtonType.primary,
            onPressed: buttonAction,
          ),
        ),
        const SizedBox(height: 40),
        TextButtonWidget(
          text: '¿No tienes cuenta?',
          linkText: 'Créate una',
          onTap: () {
            final dataToRegister = {
              'userName': _userName,
            };
            context.goNamed(
              RegisterScreen.name,
              extra: dataToRegister,
            );
          },
        ),
      ],
    );
  }

  void _checkForm() {
    setState(() {
      _isButtonEnabled = _userName.isNotEmpty && _password.isNotEmpty;
    });
  }
}
