import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/features/auth/manager/cubit/auth_cubit.dart';
import 'package:launguagelearning/features/auth/views/signIn_screen.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  static const String routeName = '/signup';

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _register(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    cubit.parentRegister(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      role: 'ADMIN', // or 'parent' or 'son' depending on your flow
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else {
          Navigator.popUntil(context, (route) => route.isFirst);
        }

        if (state is AuthRegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
          Navigator.pushNamed(context, SignIn.routeName);
        } else if (state is AuthRegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 844,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 235,
                  top: -16,
                  child: Container(
                    width: 398,
                    height: 398,
                    decoration: const ShapeDecoration(
                      color: Color(0xFFE4DB7C),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: -184,
                  top: -412,
                  child: Container(
                    width: 700,
                    height: 700,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF221C6B),
                      shape: OvalBorder(),
                    ),
                  ),
                ),
                Positioned(
                  left: 36,
                  top: 132,
                  child: Text(
                    'Welcome In\nLanguage Learning',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 46,
                      fontFamily: 'Futura Hv BT',
                      height: 1.2,
                    ),
                  ),
                ),
                Positioned(
                  left: 36,
                  top: 300,
                  right: 36,
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Your Name',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 36,
                  top: 370,
                  right: 36,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 36,
                  top: 440,
                  right: 36,
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 36,
                  top: 600,
                  child: GestureDetector(
                    onTap: () => _register(context),
                    child: Row(
                      children: [
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: 'Futura Hv BT',
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: const BoxDecoration(
                            color: Color(0xFF8A4C7D),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 41,
                  top: 740,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SignIn.routeName);
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'Futura Hv BT',
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
