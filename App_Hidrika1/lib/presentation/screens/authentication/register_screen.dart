import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';

import '../screens.dart';
import '../../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  static var name = 'register_screen';

  final String? email;

  const RegisterScreen({super.key, this.email});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userName = '';
  String _password = '';
  String _email = '';
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _userName = widget.email ?? '';
  }

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
          context.read<EmpresaViewModel>().register(_userName, _email, _password);
          context.goNamed(HomeScreen.name);
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
          text: 'Crea tu cuenta',
          textType: TextType.title,
        ),
        const CustomTextWidget(
          text: 'Ingresa tus datos',
          textType: TextType.subtitle,
        ),
        const SizedBox(height: 40),
        CustomInputFieldWidget(
          value: _userName,
          hintText: 'usuario',
          // onChanged: (value) => _userName = value,
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
          value: _email,
          hintText: 'email',
          onChanged: (value) {
            _email = value;
            _checkForm();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu email';
            } else if (!value.contains('@')) {
              return 'Por favor ingresa un email válido';
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
            text: 'Registrate',
            type: ButtonType.primary,
            onPressed: buttonAction,
          ),
        ),
        const SizedBox(height: 40),
        TextButtonWidget(
          text: '¿Ya tienes cuenta?',
          linkText: 'Identificate',
          onTap: () {
            context.goNamed(LoginScreen.name);
          },
        ),
      ],
    );
  }

  void _checkForm() {
    setState(() {
      _isButtonEnabled =
          _userName.isNotEmpty && _email.isNotEmpty && _password.isNotEmpty;
    });
  }
}
