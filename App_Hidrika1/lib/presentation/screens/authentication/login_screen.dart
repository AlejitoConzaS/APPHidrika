import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../view_models/view_models.dart';

import '../screens.dart';
import '../../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  static var name = 'login_screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
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
    final viewmodel = context.watch<EmpresaViewModel>();
    VoidCallback? buttonAction;

    if (_isButtonEnabled) {
      
      buttonAction = () async {
        if (_formKey.currentState!.validate()) {
          try {
            await context.read<EmpresaViewModel>().login(_email, _password);
            if (context.mounted) {
              context.goNamed(HomeScreen.name);
            }
          } catch (e) {
            if (context.mounted) {
              _showErrorDialog(context, e.toString());
            
            }
          }
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
          value: _email,
          hintText: 'email',
          onChanged: (value) {
            _email = value;
            _checkForm();
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu email';
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
              'userName': _email,
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
      _isButtonEnabled = _email.isNotEmpty && _password.isNotEmpty;
    });
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error de acceso'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showSnackBarError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
