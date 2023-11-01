
import 'package:kese_events/features/event/dataprovider/tag_dataprovider.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/tag/tag.dart';

class TagRepository {
  final TagDataProvider _tagDataProvider;

  TagRepository(
    this._tagDataProvider,
  );

  Future<List<Tag>> getTags() async {
    return _tagDataProvider.getTags();
  }


  // Future<Event> getTagById(String id) async {
  //   return _tagDataProvider.getEventById(id);
  // }
}
