class EventModel {
  String title;
  String imageUrl;
  String description;
  String service;
  String price;
  String package;
  String theme;
  String eventtype;
  String event_date;

  EventModel({
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.service,
    required this.price,
    required this.package,
    required this.theme,
    required this.eventtype,
    required this.event_date,
  });

  static EventModel fromFirestore(Map<String, dynamic> data) {
    return EventModel(
      imageUrl: data['imageurl'] ?? '',
      title: data['title'] ?? '',
      eventtype: data['event_type'] ?? '',
      description: '',
      service: '',
      price: '',
      package: '',
      theme: '',
      event_date: '',
    );
  }
}

class ThemeModel {
  String theme;
  String themetitle;
  String themeimage;
  String themedescription;
  String themedecoration;
  String themeactivities;

  ThemeModel({
    required this.theme,
    required this.themetitle,
    required this.themeimage,
    required this.themedescription,
    required this.themedecoration,
    required this.themeactivities,
  });
}
