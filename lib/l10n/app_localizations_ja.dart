// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get currentPortfolio => '現在のポートフォリオ';

  @override
  String get totalLabel => '合計';

  @override
  String get viewAll => 'すべて表示';

  @override
  String get subtotal => '小計';

  @override
  String get ratesOutdated => 'レートが古い可能性があります';

  @override
  String get categoryLent => '貸付';

  @override
  String get categoryDebt => '借入';

  @override
  String get categoryBalance => '残高';

  @override
  String get badgeOutbound => '貸出中';

  @override
  String get badgeInbound => '借入中';

  @override
  String get badgeAvailable => '利用可能';

  @override
  String get addNewItem => '新規追加';

  @override
  String get nameField => '名前';

  @override
  String get nameHint => '例: 人または口座';

  @override
  String get amountField => '金額';

  @override
  String get addItem => '追加';

  @override
  String get selectCurrency => '通貨を選択';

  @override
  String get searchCurrencyHint => '通貨またはコードを検索';

  @override
  String get recent => '最近';

  @override
  String get allCurrencies => 'すべての通貨';

  @override
  String get results => '結果';

  @override
  String get deleteItemTitle => '項目を削除しますか？';

  @override
  String get deleteItemMessage => 'この項目を削除してもよろしいですか？この操作は取り消せません。';

  @override
  String get delete => '削除';

  @override
  String get cancel => 'キャンセル';

  @override
  String get editItem => '項目を編集';

  @override
  String get activeRecord => '対象の記録';

  @override
  String get adjustAmount => '金額を調整';

  @override
  String get subtract => '減算';

  @override
  String get add => '加算';

  @override
  String get whereDoesItGo => 'この金額の移動先は？';

  @override
  String get whereFrom => '移動元は？';

  @override
  String get moveToBalance => '残高へ移動';

  @override
  String get moveFromBalance => '残高から移動';

  @override
  String get moveToBalanceSubtitle => 'これらの資金を流動資産に戻します。';

  @override
  String get moveFromBalanceSubtitle => 'これらの資金を流動資産から差し引きます。';

  @override
  String get targetWallet => '移動先のウォレット';

  @override
  String get sourceWallet => '移動元のウォレット';

  @override
  String get forgivenTitle => '免除 / 消滅';

  @override
  String get forgivenSubtitle => '金額は差し引かれますが、収入としては記録されません。';

  @override
  String get noWallets => '残高ウォレットがまだありません。先に追加してください。';

  @override
  String get saveTransfer => '保存して移動';

  @override
  String get helperSubtract => '返済された、または合計から差し引く金額を入力してください。';

  @override
  String get helperAdd => 'この記録に追加する金額を入力してください。';

  @override
  String get activePositions => 'アクティブなポジション';

  @override
  String get sort => '並び替え';

  @override
  String get sortAmountDesc => '金額: 高い順';

  @override
  String get sortAmountAsc => '金額: 低い順';

  @override
  String get sortNameAsc => '名前: A→Z';

  @override
  String get totalAssetsLent => '貸付総額';

  @override
  String get totalDebt => '借入総額';

  @override
  String get totalBalance => '残高総額';

  @override
  String get itemNotFound => '項目が見つかりません';

  @override
  String get language => '言語';
}
