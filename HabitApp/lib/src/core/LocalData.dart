class LocalData {

    // Singleton pattern 
  LocalData._init();
  static final LocalData _instance = new LocalData._init();

  // Use dart's factory constructor to implement this pattern
  factory LocalData() {
    return _instance;
  }

  /// Load data and do other things here before app starts
  Future init() async {

  }

  String getInitialRoute() {
    return '/intro';
  }

}