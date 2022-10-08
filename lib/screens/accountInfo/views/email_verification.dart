
import 'package:flutter/material.dart';
import 'package:flutter_project_structure/constants/app_constants.dart';
import 'package:flutter_project_structure/constants/app_string_constant.dart';
import 'package:flutter_project_structure/customWidgtes/common_outlined_button.dart';
import 'package:flutter_project_structure/customWidgtes/common_text_field.dart';
import 'package:flutter_project_structure/helper/app_localizations.dart';

Widget verificationContainer(BuildContext context, AppLocalizations? _localizations,TextEditingController emailController, VoidCallback callback){
  return Card(
    child: Stack(
      children: [
        Container(
          color: AppColors.lightGray,
          height: AppSizes.height / 4,
        ),
        Padding(
          padding: const EdgeInsets.all(AppSizes.extraPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Text(
                    _localizations?.translate(AppStringConstant.verificationTitle) ?? '',
                    style: const TextStyle(color: AppColors.white),
                  )),
              const SizedBox(height: AppSizes.normalPadding,),
              CommonTextField(
                controller: emailController,
                isPassword: false,
                readOnly: true,
              ),
              const SizedBox(height: AppSizes.normalPadding,),

              commonButton(context, callback, (_localizations?.translate(AppStringConstant.resendLink) ?? '').toUpperCase(),
                  backgroundColor: AppColors.black,
                  textColor: AppColors.white)
            ],
          ),
        ),
      ],
    ),
  );
}
