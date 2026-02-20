import 'package:bhutpurva_penal/core/constants/text_const.dart';
import 'package:bhutpurva_penal/features/auth/login/controllers/login_controller.dart';
import 'package:bhutpurva_penal/shared/widgets/text_fields/outer_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LoginForm extends GetView<LoginController> {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.06),
            //   blurRadius: 16,
            //   offset: const Offset(0, 8),
            // ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 🔹 TITLE
            Text(
              'Welcome Back 👋',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(6),

            /// 🔹 SUBTITLE
            Text(
              'Login to continue',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),

            const Gap(24),

            /// EMAIL
            OuterLabelTextField(
              label: TextConst.email,
              hint: 'Enter your email',
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
              prefixIcon: const Icon(PhosphorIconsBold.paperPlaneRight),
              enabledBorderColor: Colors.black.withOpacity(0.3),
              opacity: 0.0,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.next,
            ),

            const Gap(14),

            /// PASSWORD
            Obx(
              () => OuterLabelTextField(
                label: TextConst.password,
                hint: 'Enter your password',
                controller: controller.passwordController,
                obscureText: controller.isPasswordHidden.value,
                prefixIcon: Icon(PhosphorIconsBold.password),
                enabledBorderColor: Colors.black.withOpacity(0.3),
                opacity: 0.0,
                autofillHints: const [AutofillHints.password],
                textInputAction: TextInputAction.done,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.isPasswordHidden.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: controller.togglePasswordVisibility,
                ),
              ),
            ),

            const Gap(10),

            /// FORGOT PASSWORD
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: controller.onForgotPassword,
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),

            const Gap(16),

            /// LOGIN BUTTON
            SizedBox(
              height: 40,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.onLogin,
                  style: ElevatedButton.styleFrom(elevation: 0).copyWith(
                    overlayColor: WidgetStateProperty.all(
                      Colors.white.withOpacity(0.08),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
