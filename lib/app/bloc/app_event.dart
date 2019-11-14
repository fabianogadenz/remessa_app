abstract class AppEvent {
  const AppEvent();
}

class RefreshLoginEvent extends AppEvent {
  @override
  String toString() => 'RefreshLoginEvent';
}
