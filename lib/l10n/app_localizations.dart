import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('ja'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// No description provided for @currentPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Current Portfolio'**
  String get currentPortfolio;

  /// No description provided for @totalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total '**
  String get totalLabel;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get viewAll;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @ratesOutdated.
  ///
  /// In en, this message translates to:
  /// **'Rates may be outdated'**
  String get ratesOutdated;

  /// No description provided for @categoryLent.
  ///
  /// In en, this message translates to:
  /// **'They owe me'**
  String get categoryLent;

  /// No description provided for @categoryDebt.
  ///
  /// In en, this message translates to:
  /// **'I owe'**
  String get categoryDebt;

  /// No description provided for @categoryBalance.
  ///
  /// In en, this message translates to:
  /// **'On hand'**
  String get categoryBalance;

  /// No description provided for @badgeOutbound.
  ///
  /// In en, this message translates to:
  /// **'Outbound'**
  String get badgeOutbound;

  /// No description provided for @badgeInbound.
  ///
  /// In en, this message translates to:
  /// **'Inbound'**
  String get badgeInbound;

  /// No description provided for @badgeAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get badgeAvailable;

  /// No description provided for @addNewItem.
  ///
  /// In en, this message translates to:
  /// **'Add New Item'**
  String get addNewItem;

  /// No description provided for @nameField.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameField;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Person or Account'**
  String get nameHint;

  /// No description provided for @amountField.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountField;

  /// No description provided for @addItem.
  ///
  /// In en, this message translates to:
  /// **'Add Item'**
  String get addItem;

  /// No description provided for @selectCurrency.
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get selectCurrency;

  /// No description provided for @searchCurrencyHint.
  ///
  /// In en, this message translates to:
  /// **'Search currency or code'**
  String get searchCurrencyHint;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @allCurrencies.
  ///
  /// In en, this message translates to:
  /// **'All Currencies'**
  String get allCurrencies;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @deleteItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Item?'**
  String get deleteItemTitle;

  /// No description provided for @deleteItemMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this item? This action cannot be undone.'**
  String get deleteItemMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @editItem.
  ///
  /// In en, this message translates to:
  /// **'Edit Item'**
  String get editItem;

  /// No description provided for @activeRecord.
  ///
  /// In en, this message translates to:
  /// **'Active Record'**
  String get activeRecord;

  /// No description provided for @adjustAmount.
  ///
  /// In en, this message translates to:
  /// **'Adjust Amount'**
  String get adjustAmount;

  /// No description provided for @subtract.
  ///
  /// In en, this message translates to:
  /// **'Subtract'**
  String get subtract;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @whereDoesItGo.
  ///
  /// In en, this message translates to:
  /// **'Where does this amount go?'**
  String get whereDoesItGo;

  /// No description provided for @whereFrom.
  ///
  /// In en, this message translates to:
  /// **'Where from?'**
  String get whereFrom;

  /// No description provided for @moveToBalance.
  ///
  /// In en, this message translates to:
  /// **'Move to Balance'**
  String get moveToBalance;

  /// No description provided for @moveFromBalance.
  ///
  /// In en, this message translates to:
  /// **'Move from Balance'**
  String get moveFromBalance;

  /// No description provided for @moveToBalanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add these funds back to your liquid assets.'**
  String get moveToBalanceSubtitle;

  /// No description provided for @moveFromBalanceSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Deduct these funds from your liquid assets.'**
  String get moveFromBalanceSubtitle;

  /// No description provided for @targetWallet.
  ///
  /// In en, this message translates to:
  /// **'Target Wallet'**
  String get targetWallet;

  /// No description provided for @sourceWallet.
  ///
  /// In en, this message translates to:
  /// **'Source Wallet'**
  String get sourceWallet;

  /// No description provided for @forgivenTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgiven / Gone'**
  String get forgivenTitle;

  /// No description provided for @forgivenSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The amount will be deducted, but not tracked as an inflow.'**
  String get forgivenSubtitle;

  /// No description provided for @noWallets.
  ///
  /// In en, this message translates to:
  /// **'No balance wallets yet. Add one first.'**
  String get noWallets;

  /// No description provided for @saveTransfer.
  ///
  /// In en, this message translates to:
  /// **'Save & Transfer'**
  String get saveTransfer;

  /// No description provided for @helperSubtract.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount that has been returned or needs to be deducted from the total.'**
  String get helperSubtract;

  /// No description provided for @helperAdd.
  ///
  /// In en, this message translates to:
  /// **'Enter the additional amount to add to this record.'**
  String get helperAdd;

  /// No description provided for @activePositions.
  ///
  /// In en, this message translates to:
  /// **'Active Positions'**
  String get activePositions;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @sortAmountDesc.
  ///
  /// In en, this message translates to:
  /// **'Amount: high to low'**
  String get sortAmountDesc;

  /// No description provided for @sortAmountAsc.
  ///
  /// In en, this message translates to:
  /// **'Amount: low to high'**
  String get sortAmountAsc;

  /// No description provided for @sortNameAsc.
  ///
  /// In en, this message translates to:
  /// **'Name: A to Z'**
  String get sortNameAsc;

  /// No description provided for @totalAssetsLent.
  ///
  /// In en, this message translates to:
  /// **'Total Assets Lent'**
  String get totalAssetsLent;

  /// No description provided for @totalDebt.
  ///
  /// In en, this message translates to:
  /// **'Total Debt'**
  String get totalDebt;

  /// No description provided for @totalBalance.
  ///
  /// In en, this message translates to:
  /// **'Total Balance'**
  String get totalBalance;

  /// No description provided for @itemNotFound.
  ///
  /// In en, this message translates to:
  /// **'Item not found'**
  String get itemNotFound;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @fundFromWallet.
  ///
  /// In en, this message translates to:
  /// **'Where do you take it from?'**
  String get fundFromWallet;

  /// No description provided for @fundToWallet.
  ///
  /// In en, this message translates to:
  /// **'Where does it go?'**
  String get fundToWallet;

  /// No description provided for @notFromBalance.
  ///
  /// In en, this message translates to:
  /// **'Not from balance'**
  String get notFromBalance;

  /// No description provided for @notToBalance.
  ///
  /// In en, this message translates to:
  /// **'Not to balance'**
  String get notToBalance;

  /// No description provided for @informationalHint.
  ///
  /// In en, this message translates to:
  /// **'This entry won\'t affect your total.'**
  String get informationalHint;

  /// No description provided for @paywallTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Even'**
  String get paywallTitle;

  /// No description provided for @paywallSubtitle.
  ///
  /// In en, this message translates to:
  /// **'One-time payment. Yours forever.'**
  String get paywallSubtitle;

  /// No description provided for @paywallFeatures.
  ///
  /// In en, this message translates to:
  /// **'Unlimited records · all currencies & live rates · all languages'**
  String get paywallFeatures;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get restore;

  /// No description provided for @freeLimitNote.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached the free limit of records.'**
  String get freeLimitNote;

  /// No description provided for @purchaseThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Everything is unlocked.'**
  String get purchaseThanks;

  /// No description provided for @purchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase could not be completed.'**
  String get purchaseFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'ja',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'ja':
      return AppLocalizationsJa();
    case 'ru':
      return AppLocalizationsRu();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
