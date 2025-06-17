class ProfileQueries{
  static const queryProfile = '''
    query GetProfile {
      profile {
        name
        phone
      }
    }
    ''';
}