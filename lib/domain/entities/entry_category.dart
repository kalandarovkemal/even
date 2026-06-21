enum EntryCategory {
  lent,
  debt,
  balance;

  static EntryCategory fromName(String value) =>
      EntryCategory.values.firstWhere((e) => e.name == value);
}
