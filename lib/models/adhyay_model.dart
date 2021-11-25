class Adhyay {
  String title;
  String story;
  Adhyay({
    required this.title,
    required this.story,
  });

  get getTitle => this.title;

  set setTitle(String title) => this.title = title;
  get getStory => this.story;

  set setStory(String story) => this.story = story;
}
