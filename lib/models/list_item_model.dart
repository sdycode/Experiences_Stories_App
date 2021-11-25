class ListItemModel {
  String id;
  String anubhutiId;
  String title;
  bool isUpdated;
  ListItemModel({
    required this.id,
    required this.anubhutiId,
    required this.title,
    required this.isUpdated,
  });
  get getId => id;

  set setId(id) => this.id = id;

  get getAnubhutiId => anubhutiId;

  set setAnubhutiId(anubhutiId) => this.anubhutiId = anubhutiId;

  get getTitle => title;

  set setTitle(title) => this.title = title;

  get getIsUpdated => isUpdated;

  set setIsUpdated(isUpdated) => this.isUpdated = isUpdated;
}
