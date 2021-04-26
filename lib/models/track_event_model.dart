class TrackEvent {
  String name;
  Map<String, dynamic> properties;

  TrackEvent({
    this.name,
    this.properties,
  });

  TrackEvent.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    properties = json['properties'];
  }
}
