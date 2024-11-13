import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Provider/providers.dart';
import '../viewmodels/post_view_model.dart';

class Calendar extends ConsumerWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(postDateProvider) ?? DateTime.now();
    final posts = ref.watch(postProvider);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: selectedDay,
              selectedDayPredicate: (day) => isSameDay(selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                ref.read(postDateProvider.notifier).state = selectedDay;
                ref.read(postProvider.notifier).fetchPostsForDay(selectedDay);
              },
              calendarFormat: CalendarFormat.month,
            ),
          ),
          Expanded(
            child: posts.isEmpty
                ? const Center(child: Text("まだ投稿はありません"))
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];

                      return Card(
                        child: ListTile(
                          subtitle: Column(
                            children: [
                              if (post.imageFile != null)
                                Image.network(post.imageFile!)
                              else
                                Container(),
                              Row(
                                children: [
                                  Text(
                                    '${post.date.year}/${post.date.month}/${post.date.day}',
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      final localId = post.localId;
                                      if(localId != null){
                                        ref.read(postProvider.notifier).deletePost(localId);
                                      }
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}