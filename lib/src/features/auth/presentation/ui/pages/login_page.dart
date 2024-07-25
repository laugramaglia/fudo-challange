import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_flutter/src/core/mixins/loading_overlay_mixin.dart';
import 'package:fudo_flutter/src/core/utils/extensions/context_extension.dart';
import 'package:fudo_flutter/src/features/auth/presentation/providers/sign_in_email_provider.dart';
import 'package:fudo_flutter/src/features/auth/presentation/ui/widgets/text_field_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign In'),
          automaticallyImplyLeading: false,
        ),
        body: const _Body());
  }
}

class _Body extends ConsumerStatefulWidget {
  const _Body();

  @override
  ConsumerState<_Body> createState() => _BodyState();
}

class _BodyState extends ConsumerState<_Body> with LoadingOverlayMixin {
  late final OverlayEntry _overlayEntry;
  final TextEditingController _emailController = TextEditingController(),
      _passwordController = TextEditingController();
  bool validated = false;

  @override
  void initState() {
    super.initState();
    _overlayEntry = initOverlay();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _overlayEntry.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextFieldWidget(
            hintText: 'Enter your Email',
            icon: Icons.email_rounded,
            controller: _emailController,
          ),
          if ((_emailController.value.text.length < 5 ||
                  !_emailController.value.text.contains('@')) &&
              validated) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Invalid Email',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
          const SizedBox(height: 16),
          TextFieldWidget(
            hintText: 'Enter your password',
            icon: Icons.lock_rounded,
            isPass: true,
            controller: _passwordController,
          ),
          if (_passwordController.value.text.isEmpty && validated) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _passwordController.value.text.isEmpty
                    ? 'Invalid password'
                    : 'Passwords do not match',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                context.errorSnackBar('Not yet implemented');
              },
              child: const Text('Forgot Password'),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
              onPressed: () async {
                if (_emailController.value.text.length < 5 ||
                    !_emailController.value.text.contains('@') ||
                    _passwordController.value.text.isEmpty) {
                  setState(() {
                    validated = true;
                  });
                  return;
                }
                Overlay.of(context).insert(_overlayEntry);
                setState(() {
                  validated = false;
                });

                await ref
                    .read(signInEmailProvider(
                  email: _emailController.text,
                  password: _passwordController.text,
                ).future)
                    .then((value) {
                  if (value?.id != null) {
                    context.successSnackBar('Signed in successfully');
                    // const HomeRoute().go(context);
                  }
                  return value;
                }, onError: (error, stackTrace) {
                  context.errorSnackBar(error.toString());
                  return null;
                }).whenComplete(() {
                  _overlayEntry.remove();
                });
              },
              child: const Center(child: Text('Sign in'))),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Don\'t have an account? '),
                TextSpan(
                  text: 'Sign up',
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.errorSnackBar('Not yet implemented');
                    },
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
