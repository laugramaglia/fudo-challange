import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fudo_flutter/src/features/persons/domain/entities/person_entity.dart';
import 'package:fudo_flutter/src/features/posts/presentation/providers/get_posts_provider.dart';
import 'package:fudo_flutter/src/features/persons/presentation/providers/get_persons.dart';
import 'package:fudo_flutter/src/features/persons/presentation/providers/serarch_history_provider.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  const SearchBarWidget({super.key});

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  late final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    final personsState = ref.watch(getPersonsProvider);
    final searchHistory = ref.watch(searchHistoryProvider);
    return SearchAnchor.bar(
      barHintText: 'Search persons',
      searchController: controller,
      onChanged: (value) {
        if (value.isEmpty) {
          ref.read(getPostsProvider.notifier).filter();
          return;
        }
      },
      onSubmitted: (value) {
        //get person id
        final person = value.isEmpty
            ? null
            : personsState.value
                ?.where(
                  (element) =>
                      element.name.toLowerCase() == value.toLowerCase(),
                )
                .firstOrNull;
        // filter posts
        ref.read(getPostsProvider.notifier).filter(person?.id);
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        return personsState.when(
          error: (error, stackTrace) => <Widget>[Text(error.toString())],
          loading: () =>
              <Widget>[const Center(child: CircularProgressIndicator())],
          data: (persons) {
            if (controller.text.isEmpty) {
              if (searchHistory.isNotEmpty) {
                return getHistoryList(controller, searchHistory);
              }
              return <Widget>[
                Center(
                    child: Text('No search history.',
                        style: Theme.of(context).textTheme.bodyMedium))
              ];
            }
            return getSuggestions(controller, persons);
          },
        );
      },
    );
  }

  Iterable<Widget> getHistoryList(
      SearchController controller, List<PersonEntity> searchHistory) {
    return searchHistory.map(
      (PersonEntity person) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(person.name),
        trailing: const Icon(Icons.call_missed),
        onTap: () {
          // set the search text
          controller.closeView(person.name);
          controller.text = person.name;
          controller.selection =
              TextSelection.collapsed(offset: controller.text.length);
        },
      ),
    );
  }

  Iterable<Widget> getSuggestions(
      SearchController controller, List<PersonEntity> persons) {
    final String input = controller.value.text;
    return persons
        .where(
            (PersonEntity person) => person.name.toLowerCase().contains(input))
        .map(
          (PersonEntity person) => ListTile(
            leading: const CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
            ),
            title: Text(person.name),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = person.name;
                controller.selection =
                    TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              // set the search text
              controller.closeView(person.name);
              // add to search history
              ref.read(searchHistoryProvider.notifier).add(person);
            },
          ),
        );
  }
}
