import 'package:flutter/material.dart' hide Route;
import 'package:go_router/go_router.dart';
import 'package:location_report/core/theme/extensions.dart';
import 'package:location_report/core/util/input_validator.dart';

import '../../../../router/routes.dart';
import '../../shared/presentation/widgets/primary_button.dart';
import '../widgets/input_title.dart';
import '../widgets/text_field.dart';

class LoginScreen extends StatelessWidget{
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 66, left: 18, right: 18),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Welcome back \u{1F44B}', style: context.theme.textTheme.titleLarge,),
                  SizedBox(height: 32,),
                  InputTitle(text: 'Email'),
                  TextInputField(
                    hint: 'Enter your email address',
                    onChanged: (_){},
                    inputType: TextInputType.emailAddress,
                    validator: InputValidators.validateEmail,
                  ),
                  InputTitle(text: 'Password'),
                  TextInputField(
                    hint: 'Enter your password',
                    onChanged: (_){},
                    inputType: TextInputType.visiblePassword,
                    validator: InputValidators.validatePassword,
                  ),
                  SizedBox(height: 28,),
                  PrimaryButton(
                      text: 'Log in',
                      onPressed: (){
                        if(_formKey.currentState?.validate() == true){
                          context.go(Route.dashboard);
                        }
                      }
                  )
                ],
              )
          ),
        ),
      ),
    );
  }

}