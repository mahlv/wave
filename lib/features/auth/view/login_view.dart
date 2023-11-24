import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soundtt/common/loading_page.dart';
import 'package:soundtt/common/rounded_small_button.dart';
import 'package:soundtt/constants/constants.dart';
import 'package:soundtt/features/auth/controller/auth_controller.dart';
import 'package:soundtt/features/auth/view/signup_view.dart';
import 'package:soundtt/features/auth/widgets/auth_field.dart';
import 'package:soundtt/theme/pallete.dart';

class LoginView extends ConsumerStatefulWidget {
  static route () => MaterialPageRoute(
        builder: (context) => LoginView(),
      );
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final appbar = UIConstants.appBar();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() {
  ref.read(authControllerProvider.notifier).login(
    email: emailController.text, 
    password: passwordController.text, 
    context: context,
  );
}

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: appbar,
      body:  isLoading
        ? const Loader()
        : Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                 children: [
                  // textfield 1 
                 AuthField(controller: emailController, hintText: 'Email',),
                  const SizedBox(height: 40),
                // textfield 2    
                  AuthField(controller: passwordController, hintText: 'Password',),
                // button 
                  const SizedBox(height: 40),

                Align(
                  alignment: Alignment.topRight,
                  child: RoundedSmallButton(
                    onTap: onLogin,
                   label: 'Done',
                   backgroundColor: Pallete.whiteColor, 
                   textColor: Pallete.backgroundColor, height: 5, 
                  ),
                ),

              const SizedBox(height: 40),
              RichText(
                text: TextSpan(
                  text: "Don't have an account?",
                                    style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 16,
                  ),
                  
                children: [
                TextSpan(
                  text: ' Sign Up',
                  style: const TextStyle(
                    color: Pallete.blueColor,
                    fontSize: 16,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    Navigator.push(
                      context,
                      SignUpView.route(),
                    );
                  },
            
              
                )
              ]
               ),
               ),

                // textspan 
              ],
      
      
          ),
         ),
        ),
      ),
    );
  }                   
}
