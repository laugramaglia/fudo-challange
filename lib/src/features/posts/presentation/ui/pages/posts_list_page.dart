import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_flutter/src/core/mixins/loading_overlay_mixin.dart';
import 'package:fudo_flutter/src/core/utils/extensions/context_extension.dart';
import 'package:fudo_flutter/src/features/connectivity/presentation/ui/widgets/signal_widget.dart';
import 'package:fudo_flutter/src/features/posts/domain/entities/post_entity.dart';
import 'package:fudo_flutter/src/features/posts/presentation/providers/create_random_post_provider.dart';
import 'package:fudo_flutter/src/features/posts/presentation/providers/get_posts_provider.dart';
import 'package:fudo_flutter/src/core/router/routes.dart';
import 'package:fudo_flutter/src/core/utils/extensions/string_extension.dart';
import 'package:fudo_flutter/src/features/persons/presentation/ui/widgets/search_bar_widget.dart';

class PostsListPage extends ConsumerStatefulWidget {
  const PostsListPage({super.key});

  @override
  ConsumerState<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends ConsumerState<PostsListPage>
    with LoadingOverlayMixin {
  late final OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _overlayEntry = initOverlay();
  }

  @override
  void dispose() {
    _overlayEntry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Overlay.of(context).insert(_overlayEntry);
          DateTime date = DateTime.now();
          final post = PostEntity(
              userId: 1,
              id: 1,
              title: "Rondom post created ${date.minute}:${date.second}",
              body:
                  "${date.hour}:${date.minute}:${date.second} on ${date.day}/${date.month}/${date.year}");
          ref.read(createRandomPostProvider(post).future).then((value) {
            context.successSnackBar('Post created successfully');
            ref.read(getPostsProvider.notifier).addPost(value);
            return value;
          }, onError: (error, stackTrace) {
            context.errorSnackBar(error.toString());
            return post;
          }).whenComplete(() {
            _overlayEntry.remove();
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          RefreshIndicator(
            onRefresh: () async => ref.refresh(getPostsProvider.future),
            child: const CustomScrollView(
              slivers: [
                SliverAppBar.medium(
                  title: Text('Posts'),
                ),
                _SearchBar(),
                SliverPadding(
                    padding: EdgeInsets.only(bottom: 32), sliver: _Data())
              ],
            ),
          ),
          const SignalWidget(),
        ],
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) => SliverToBoxAdapter(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
          child: const SearchBarWidget(),
        ),
      );
}

class _Data extends ConsumerWidget {
  const _Data();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getPostsProvider);
    return state.when(
      error: (error, stackTrace) => SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(error.toString()),
              const SizedBox(height: 16),
              Text('Pull to retry',
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        ),
      ),
      loading: () => const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator())),
      data: (items) {
        return SliverList.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];

            return ListTile(
                title: Text(item.title.capitalize(),
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(item.body.capitalize(),
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                onTap: () {
                  // Navigate to the details page.
                  PostDetailRoute(item.id).go(context);
                });
          },
        );
      },
    );
  }
}
