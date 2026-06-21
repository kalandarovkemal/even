// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get currentPortfolio => '当前投资组合';

  @override
  String get totalLabel => '总计';

  @override
  String get viewAll => '查看全部';

  @override
  String get subtotal => '小计';

  @override
  String get ratesOutdated => '汇率可能已过时';

  @override
  String get categoryLent => '借出';

  @override
  String get categoryDebt => '欠款';

  @override
  String get categoryBalance => '余额';

  @override
  String get badgeOutbound => '流出';

  @override
  String get badgeInbound => '流入';

  @override
  String get badgeAvailable => '可用';

  @override
  String get addNewItem => '添加新项目';

  @override
  String get nameField => '名称';

  @override
  String get nameHint => '例如：人员或账户';

  @override
  String get amountField => '金额';

  @override
  String get addItem => '添加';

  @override
  String get selectCurrency => '选择货币';

  @override
  String get searchCurrencyHint => '搜索货币或代码';

  @override
  String get recent => '最近';

  @override
  String get allCurrencies => '所有货币';

  @override
  String get results => '结果';

  @override
  String get deleteItemTitle => '删除项目？';

  @override
  String get deleteItemMessage => '确定要删除此项目吗？此操作无法撤销。';

  @override
  String get delete => '删除';

  @override
  String get cancel => '取消';

  @override
  String get editItem => '编辑项目';

  @override
  String get activeRecord => '当前记录';

  @override
  String get adjustAmount => '调整金额';

  @override
  String get subtract => '减少';

  @override
  String get add => '增加';

  @override
  String get whereDoesItGo => '这笔金额去向何处？';

  @override
  String get whereFrom => '来自哪里？';

  @override
  String get moveToBalance => '转入余额';

  @override
  String get moveFromBalance => '从余额转出';

  @override
  String get moveToBalanceSubtitle => '将这些资金转回您的流动资产。';

  @override
  String get moveFromBalanceSubtitle => '从您的流动资产中扣除这些资金。';

  @override
  String get targetWallet => '目标钱包';

  @override
  String get sourceWallet => '来源钱包';

  @override
  String get forgivenTitle => '豁免 / 注销';

  @override
  String get forgivenSubtitle => '金额将被扣除，但不计为收入。';

  @override
  String get noWallets => '暂无余额钱包，请先添加一个。';

  @override
  String get saveTransfer => '保存并转移';

  @override
  String get helperSubtract => '请输入已归还或需从总额中扣除的金额。';

  @override
  String get helperAdd => '请输入要追加到此记录的金额。';

  @override
  String get activePositions => '活动头寸';

  @override
  String get sort => '排序';

  @override
  String get sortAmountDesc => '金额：从高到低';

  @override
  String get sortAmountAsc => '金额：从低到高';

  @override
  String get sortNameAsc => '名称：A 到 Z';

  @override
  String get totalAssetsLent => '借出总额';

  @override
  String get totalDebt => '欠款总额';

  @override
  String get totalBalance => '余额总额';

  @override
  String get itemNotFound => '未找到项目';

  @override
  String get language => '语言';
}
