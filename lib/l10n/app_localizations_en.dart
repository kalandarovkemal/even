// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get currentPortfolio => 'Current Portfolio';

  @override
  String get totalLabel => 'Total';

  @override
  String get viewAll => 'View All';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get ratesOutdated => 'Rates may be outdated';

  @override
  String get categoryLent => 'Lent';

  @override
  String get categoryDebt => 'Debt';

  @override
  String get categoryBalance => 'Balance';

  @override
  String get badgeOutbound => 'Outbound';

  @override
  String get badgeInbound => 'Inbound';

  @override
  String get badgeAvailable => 'Available';

  @override
  String get addNewItem => 'Add New Item';

  @override
  String get nameField => 'Name';

  @override
  String get nameHint => 'e.g. Person or Account';

  @override
  String get amountField => 'Amount';

  @override
  String get addItem => 'Add Item';

  @override
  String get selectCurrency => 'Select Currency';

  @override
  String get searchCurrencyHint => 'Search currency or code';

  @override
  String get recent => 'Recent';

  @override
  String get allCurrencies => 'All Currencies';

  @override
  String get results => 'Results';

  @override
  String get deleteItemTitle => 'Delete Item?';

  @override
  String get deleteItemMessage =>
      'Are you sure you want to remove this item? This action cannot be undone.';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get editItem => 'Edit Item';

  @override
  String get activeRecord => 'Active Record';

  @override
  String get adjustAmount => 'Adjust Amount';

  @override
  String get subtract => 'Subtract';

  @override
  String get add => 'Add';

  @override
  String get whereDoesItGo => 'Where does this amount go?';

  @override
  String get whereFrom => 'Where from?';

  @override
  String get moveToBalance => 'Move to Balance';

  @override
  String get moveFromBalance => 'Move from Balance';

  @override
  String get moveToBalanceSubtitle =>
      'Add these funds back to your liquid assets.';

  @override
  String get moveFromBalanceSubtitle =>
      'Deduct these funds from your liquid assets.';

  @override
  String get targetWallet => 'Target Wallet';

  @override
  String get sourceWallet => 'Source Wallet';

  @override
  String get forgivenTitle => 'Forgiven / Gone';

  @override
  String get forgivenSubtitle =>
      'The amount will be deducted, but not tracked as an inflow.';

  @override
  String get noWallets => 'No balance wallets yet. Add one first.';

  @override
  String get saveTransfer => 'Save & Transfer';

  @override
  String get helperSubtract =>
      'Enter the amount that has been returned or needs to be deducted from the total.';

  @override
  String get helperAdd => 'Enter the additional amount to add to this record.';

  @override
  String get activePositions => 'Active Positions';

  @override
  String get sort => 'Sort';

  @override
  String get sortAmountDesc => 'Amount: high to low';

  @override
  String get sortAmountAsc => 'Amount: low to high';

  @override
  String get sortNameAsc => 'Name: A to Z';

  @override
  String get totalAssetsLent => 'Total Assets Lent';

  @override
  String get totalDebt => 'Total Debt';

  @override
  String get totalBalance => 'Total Balance';

  @override
  String get itemNotFound => 'Item not found';

  @override
  String get language => 'Language';
}
