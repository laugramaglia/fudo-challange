// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_email_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$signInEmailHash() => r'b7d78ee1b29d8440802a843f8ae6e1d528d0bf82';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [signInEmail].
@ProviderFor(signInEmail)
const signInEmailProvider = SignInEmailFamily();

/// See also [signInEmail].
class SignInEmailFamily extends Family<AsyncValue<UserEntity?>> {
  /// See also [signInEmail].
  const SignInEmailFamily();

  /// See also [signInEmail].
  SignInEmailProvider call({
    required String email,
    required String password,
  }) {
    return SignInEmailProvider(
      email: email,
      password: password,
    );
  }

  @override
  SignInEmailProvider getProviderOverride(
    covariant SignInEmailProvider provider,
  ) {
    return call(
      email: provider.email,
      password: provider.password,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'signInEmailProvider';
}

/// See also [signInEmail].
class SignInEmailProvider extends AutoDisposeFutureProvider<UserEntity?> {
  /// See also [signInEmail].
  SignInEmailProvider({
    required String email,
    required String password,
  }) : this._internal(
          (ref) => signInEmail(
            ref as SignInEmailRef,
            email: email,
            password: password,
          ),
          from: signInEmailProvider,
          name: r'signInEmailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$signInEmailHash,
          dependencies: SignInEmailFamily._dependencies,
          allTransitiveDependencies:
              SignInEmailFamily._allTransitiveDependencies,
          email: email,
          password: password,
        );

  SignInEmailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.email,
    required this.password,
  }) : super.internal();

  final String email;
  final String password;

  @override
  Override overrideWith(
    FutureOr<UserEntity?> Function(SignInEmailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SignInEmailProvider._internal(
        (ref) => create(ref as SignInEmailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        email: email,
        password: password,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<UserEntity?> createElement() {
    return _SignInEmailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SignInEmailProvider &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, email.hashCode);
    hash = _SystemHash.combine(hash, password.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SignInEmailRef on AutoDisposeFutureProviderRef<UserEntity?> {
  /// The parameter `email` of this provider.
  String get email;

  /// The parameter `password` of this provider.
  String get password;
}

class _SignInEmailProviderElement
    extends AutoDisposeFutureProviderElement<UserEntity?> with SignInEmailRef {
  _SignInEmailProviderElement(super.provider);

  @override
  String get email => (origin as SignInEmailProvider).email;
  @override
  String get password => (origin as SignInEmailProvider).password;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
