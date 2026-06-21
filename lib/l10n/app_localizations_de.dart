// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get currentPortfolio => 'Aktuelles Portfolio';

  @override
  String get totalLabel => 'Gesamt';

  @override
  String get viewAll => 'Alle anzeigen';

  @override
  String get subtotal => 'Zwischensumme';

  @override
  String get ratesOutdated => 'Kurse sind möglicherweise veraltet';

  @override
  String get categoryLent => 'Verliehen';

  @override
  String get categoryDebt => 'Schulden';

  @override
  String get categoryBalance => 'Guthaben';

  @override
  String get badgeOutbound => 'Ausgehend';

  @override
  String get badgeInbound => 'Eingehend';

  @override
  String get badgeAvailable => 'Verfügbar';

  @override
  String get addNewItem => 'Neuen Eintrag hinzufügen';

  @override
  String get nameField => 'Name';

  @override
  String get nameHint => 'z. B. Person oder Konto';

  @override
  String get amountField => 'Betrag';

  @override
  String get addItem => 'Hinzufügen';

  @override
  String get selectCurrency => 'Währung auswählen';

  @override
  String get searchCurrencyHint => 'Währung oder Code suchen';

  @override
  String get recent => 'Zuletzt verwendet';

  @override
  String get allCurrencies => 'Alle Währungen';

  @override
  String get results => 'Ergebnisse';

  @override
  String get deleteItemTitle => 'Eintrag löschen?';

  @override
  String get deleteItemMessage =>
      'Möchten Sie diesen Eintrag wirklich entfernen? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get delete => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get editItem => 'Eintrag bearbeiten';

  @override
  String get activeRecord => 'Aktueller Eintrag';

  @override
  String get adjustAmount => 'Betrag anpassen';

  @override
  String get subtract => 'Abziehen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get whereDoesItGo => 'Wohin fließt dieser Betrag?';

  @override
  String get whereFrom => 'Woher?';

  @override
  String get moveToBalance => 'Zum Guthaben';

  @override
  String get moveFromBalance => 'Vom Guthaben';

  @override
  String get moveToBalanceSubtitle =>
      'Diese Mittel zurück in Ihre liquiden Mittel buchen.';

  @override
  String get moveFromBalanceSubtitle =>
      'Diese Mittel von Ihren liquiden Mitteln abziehen.';

  @override
  String get targetWallet => 'Ziel-Wallet';

  @override
  String get sourceWallet => 'Quell-Wallet';

  @override
  String get forgivenTitle => 'Erlassen / Verloren';

  @override
  String get forgivenSubtitle =>
      'Der Betrag wird abgezogen, aber nicht als Zufluss erfasst.';

  @override
  String get noWallets =>
      'Noch keine Guthaben-Wallets. Fügen Sie zuerst eine hinzu.';

  @override
  String get saveTransfer => 'Speichern und übertragen';

  @override
  String get helperSubtract =>
      'Geben Sie den Betrag ein, der zurückgezahlt wurde oder vom Gesamtbetrag abgezogen werden soll.';

  @override
  String get helperAdd =>
      'Geben Sie den zusätzlichen Betrag ein, der diesem Eintrag hinzugefügt werden soll.';

  @override
  String get activePositions => 'Aktive Positionen';

  @override
  String get sort => 'Sortieren';

  @override
  String get sortAmountDesc => 'Betrag: hoch zu niedrig';

  @override
  String get sortAmountAsc => 'Betrag: niedrig zu hoch';

  @override
  String get sortNameAsc => 'Name: A bis Z';

  @override
  String get totalAssetsLent => 'Insgesamt verliehen';

  @override
  String get totalDebt => 'Gesamtschulden';

  @override
  String get totalBalance => 'Gesamtguthaben';

  @override
  String get itemNotFound => 'Eintrag nicht gefunden';

  @override
  String get language => 'Sprache';
}
