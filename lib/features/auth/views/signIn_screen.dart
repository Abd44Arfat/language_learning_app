import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launguagelearning/core/helper-function/gei_it_service.dart';
import 'package:launguagelearning/features/auth/manager/cubit/auth_cubit.dart';
import 'package:launguagelearning/features/auth/views/signup_screen.dart';
import 'package:launguagelearning/features/home/home_screen.dart';
import 'package:launguagelearning/features/levels/levels_screen.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  static const String routeName = '/signin';

  @override
  State<SignIn> createState() => _SignInState();
}




class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
            Center(child: CircularProgressIndicator());  
        } else if (state is AuthSuccess) {
          Navigator.pushReplacementNamed(context, LevelsScreen.routeName);
        } else if (state is AuthFailure) {
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
                    // Yellow and Blue Circles...
                    Positioned(
                left: 235,
                top: -16,
                child: Container(
                  width: 398,
                  height: 398,
                  decoration: ShapeDecoration(
                    color: Color(0xFFE4DB7C),
                    shape: OvalBorder(),
                  ),
                ),
              ),

              // Blue Circle
              Positioned(
                left: -184,
                top: -412,
                child: Container(
                  width: 700,
                  height: 700,
                  decoration: ShapeDecoration(
                    color: Color(0xFF221C6B),
                    shape: OvalBorder(),
                  ),
                ),
              ),

              // Welcome Back Text
              Positioned(
                left: 36,
                top: 132,
                child: Text(
                  'Welcome\nBack',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontFamily: 'Futura Hv BT',
                    height: 1.2,
                  ),
                ),
              ),
                    Positioned(
                      left: 36,
                      top: 132,
                      child: Text(
                        'Welcome\nBack',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontFamily: 'Futura Hv BT',
                          height: 1.2,
                        ),
                      ),
                    ),
            
                    // Email Field
                    Positioned(
                      left: 36,
                      top: 300,
                      right: 36,
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'Your Email',
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
            
                    // Password Field
                    Positioned(
                      left: 36,
                      top: 380,
                      right: 36,
                      child: TextField(
                        controller: _passwordController,
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
            
                    // Sign In Button
                    Positioned(
                      left: 36,
                      top: 579,
                      child: GestureDetector(
                        onTap: () {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          context.read<AuthCubit>().parentLogin(
                                email: email,
                                password: password,
                              );
                        },
                        child: Row(
                          children: [
                            Text(
                              'Sign in',
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
                              decoration: BoxDecoration(
                                color: Color(0xFF8A4C7D),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            
                    // Sign Up Link
                    Positioned(
                      left: 41,
                      top: 740,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Signup.routeName);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Futura Hv BT',
                            height: 1.2,
                          ),
                        ),
                      ),
                    ),
            
                    // Forgot Password Link
                    Positioned(
                      left: 184,
                      top: 740,
                      child: GestureDetector(
                        onTap: () {
                          // Handle forgot password
                        },
                        child: Text(
                          'Forgot Password',
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
