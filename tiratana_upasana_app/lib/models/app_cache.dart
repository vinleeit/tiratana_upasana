import 'package:objectbox/objectbox.dart';

@Entity()
final class AppCache {
  AppCache({
    this.cachedMeditationWatchStartTime,
  });

  @Id()
  int id = 0;

  DateTime? cachedMeditationWatchStartTime;
}
