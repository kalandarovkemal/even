// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get currentPortfolio => 'Portefeuille actuel';

  @override
  String get totalLabel => 'Total';

  @override
  String get viewAll => 'Tout afficher';

  @override
  String get subtotal => 'Sous-total';

  @override
  String get ratesOutdated => 'Les taux sont peut-être obsolètes';

  @override
  String get categoryLent => 'On me doit';

  @override
  String get categoryDebt => 'Je dois';

  @override
  String get categoryBalance => 'En main';

  @override
  String get badgeOutbound => 'Sortant';

  @override
  String get badgeInbound => 'Entrant';

  @override
  String get badgeAvailable => 'Disponible';

  @override
  String get addNewItem => 'Ajouter un élément';

  @override
  String get nameField => 'Nom';

  @override
  String get nameHint => 'p. ex. Personne ou compte';

  @override
  String get amountField => 'Montant';

  @override
  String get addItem => 'Ajouter';

  @override
  String get selectCurrency => 'Choisir la devise';

  @override
  String get searchCurrencyHint => 'Rechercher une devise ou un code';

  @override
  String get recent => 'Récents';

  @override
  String get allCurrencies => 'Toutes les devises';

  @override
  String get results => 'Résultats';

  @override
  String get deleteItemTitle => 'Supprimer l\'élément ?';

  @override
  String get deleteItemMessage =>
      'Voulez-vous vraiment supprimer cet élément ? Cette action est irréversible.';

  @override
  String get delete => 'Supprimer';

  @override
  String get cancel => 'Annuler';

  @override
  String get editItem => 'Modifier l\'élément';

  @override
  String get activeRecord => 'Enregistrement actif';

  @override
  String get adjustAmount => 'Ajuster le montant';

  @override
  String get subtract => 'Soustraire';

  @override
  String get add => 'Ajouter';

  @override
  String get whereDoesItGo => 'Où va ce montant ?';

  @override
  String get whereFrom => 'D\'où provient-il ?';

  @override
  String get moveToBalance => 'Vers le solde';

  @override
  String get moveFromBalance => 'Depuis le solde';

  @override
  String get moveToBalanceSubtitle =>
      'Reversez ces fonds dans vos actifs liquides.';

  @override
  String get moveFromBalanceSubtitle =>
      'Déduisez ces fonds de vos actifs liquides.';

  @override
  String get targetWallet => 'Portefeuille cible';

  @override
  String get sourceWallet => 'Portefeuille source';

  @override
  String get forgivenTitle => 'Annulé / Perdu';

  @override
  String get forgivenSubtitle =>
      'Le montant sera déduit, mais non comptabilisé comme une entrée.';

  @override
  String get noWallets =>
      'Aucun portefeuille de solde pour l\'instant. Ajoutez-en un d\'abord.';

  @override
  String get saveTransfer => 'Enregistrer et transférer';

  @override
  String get helperSubtract =>
      'Saisissez le montant qui a été remboursé ou qui doit être déduit du total.';

  @override
  String get helperAdd =>
      'Saisissez le montant supplémentaire à ajouter à cet enregistrement.';

  @override
  String get activePositions => 'Positions actives';

  @override
  String get sort => 'Trier';

  @override
  String get sortAmountDesc => 'Montant : décroissant';

  @override
  String get sortAmountAsc => 'Montant : croissant';

  @override
  String get sortNameAsc => 'Nom : de A à Z';

  @override
  String get totalAssetsLent => 'Total prêté';

  @override
  String get totalDebt => 'Dette totale';

  @override
  String get totalBalance => 'Solde total';

  @override
  String get itemNotFound => 'Élément introuvable';

  @override
  String get language => 'Langue';

  @override
  String get fundFromWallet => 'D\'où provient l\'argent ?';

  @override
  String get fundToWallet => 'Où va l\'argent ?';

  @override
  String get notFromBalance => 'Pas depuis le solde';

  @override
  String get notToBalance => 'Pas vers le solde';

  @override
  String get informationalHint => 'Cette entrée n\'affectera pas votre total.';
}
