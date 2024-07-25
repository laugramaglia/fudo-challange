// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_random_post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$createRandomPostHash() => r'63447f6e9d524e6e93af3e5d64e0f792544983ac';

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

/// See also [createRandomPost].
@ProviderFor(createRandomPost)
const createRandomPostProvider = CreateRandomPostFamily();

/// See also [createRandomPost].
class CreateRandomPostFamily extends Family<AsyncValue<PostEntity>> {
  /// See also [createRandomPost].
  const CreateRandomPostFamily();

  /// See also [createRandomPost].
  CreateRandomPostProvider call(
    PostEntity post,
  ) {
    return CreateRandomPostProvider(
      post,
    );
  }

  @override
  CreateRandomPostProvider getProviderOverride(
    covariant CreateRandomPostProvider provider,
  ) {
    return call(
      provider.post,
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
  String? get name => r'createRandomPostProvider';
}

/// See also [createRandomPost].
class CreateRandomPostProvider extends AutoDisposeFutureProvider<PostEntity> {
  /// See also [createRandomPost].
  CreateRandomPostProvider(
    PostEntity post,
  ) : this._internal(
          (ref) => createRandomPost(
            ref as CreateRandomPostRef,
            post,
          ),
          from: createRandomPostProvider,
          name: r'createRandomPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createRandomPostHash,
          dependencies: CreateRandomPostFamily._dependencies,
          allTransitiveDependencies:
              CreateRandomPostFamily._allTransitiveDependencies,
          post: post,
        );

  CreateRandomPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.post,
  }) : super.internal();

  final PostEntity post;

  @override
  Override overrideWith(
    FutureOr<PostEntity> Function(CreateRandomPostRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateRandomPostProvider._internal(
        (ref) => create(ref as CreateRandomPostRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        post: post,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PostEntity> createElement() {
    return _CreateRandomPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateRandomPostProvider && other.post == post;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, post.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateRandomPostRef on AutoDisposeFutureProviderRef<PostEntity> {
  /// The parameter `post` of this provider.
  PostEntity get post;
}

class _CreateRandomPostProviderElement
    extends AutoDisposeFutureProviderElement<PostEntity>
    with CreateRandomPostRef {
  _CreateRandomPostProviderElement(super.provider);

  @override
  PostEntity get post => (origin as CreateRandomPostProvider).post;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
