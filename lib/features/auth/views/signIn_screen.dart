import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  static const String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Yellow Circle
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

              // Email Field
              Positioned(
                left: 36,
                top: 300,
                right: 36,
                child: TextField(
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

              // Sign In Button + Icon
              Positioned(
                left: 36,
                top: 579,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // تنفيذ عملية تسجيل الدخول هنا
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontFamily: 'Futura Hv BT',
                          height: 1.2,
                        ),
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

              // Sign Up Link
              Positioned(
                left: 41,
                top: 740,
                child: GestureDetector(
                  onTap: () {
                    // روح لشاشة تسجيل حساب جديد
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
                    // روح لشاشة استرجاع كلمة المرور
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
    );
  }
}
