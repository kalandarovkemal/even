// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get currentPortfolio => 'Текущий портфель';

  @override
  String get totalLabel => 'Всего';

  @override
  String get viewAll => 'Показать все';

  @override
  String get subtotal => 'Итого';

  @override
  String get ratesOutdated => 'Курсы могут быть устаревшими';

  @override
  String get categoryLent => 'Выдано';

  @override
  String get categoryDebt => 'Долги';

  @override
  String get categoryBalance => 'Баланс';

  @override
  String get badgeOutbound => 'Исходящие';

  @override
  String get badgeInbound => 'Входящие';

  @override
  String get badgeAvailable => 'Доступно';

  @override
  String get addNewItem => 'Новая запись';

  @override
  String get nameField => 'Название';

  @override
  String get nameHint => 'напр. Человек или счёт';

  @override
  String get amountField => 'Сумма';

  @override
  String get addItem => 'Добавить';

  @override
  String get selectCurrency => 'Выбор валюты';

  @override
  String get searchCurrencyHint => 'Поиск валюты или кода';

  @override
  String get recent => 'Недавние';

  @override
  String get allCurrencies => 'Все валюты';

  @override
  String get results => 'Результаты';

  @override
  String get deleteItemTitle => 'Удалить запись?';

  @override
  String get deleteItemMessage =>
      'Вы уверены, что хотите удалить эту запись? Это действие нельзя отменить.';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get editItem => 'Редактирование';

  @override
  String get activeRecord => 'Текущая запись';

  @override
  String get adjustAmount => 'Изменить сумму';

  @override
  String get subtract => 'Вычесть';

  @override
  String get add => 'Добавить';

  @override
  String get whereDoesItGo => 'Куда направить эту сумму?';

  @override
  String get whereFrom => 'Откуда взять?';

  @override
  String get moveToBalance => 'В баланс';

  @override
  String get moveFromBalance => 'Из баланса';

  @override
  String get moveToBalanceSubtitle =>
      'Вернуть эти средства в ваши ликвидные активы.';

  @override
  String get moveFromBalanceSubtitle =>
      'Списать эти средства с ваших ликвидных активов.';

  @override
  String get targetWallet => 'Кошелёк назначения';

  @override
  String get sourceWallet => 'Кошелёк-источник';

  @override
  String get forgivenTitle => 'Прощено / Списано';

  @override
  String get forgivenSubtitle =>
      'Сумма будет вычтена, но не учтена как поступление.';

  @override
  String get noWallets => 'Пока нет кошельков баланса. Сначала добавьте один.';

  @override
  String get saveTransfer => 'Сохранить и перевести';

  @override
  String get helperSubtract =>
      'Введите сумму, которая была возвращена или должна быть вычтена из общей суммы.';

  @override
  String get helperAdd =>
      'Введите дополнительную сумму для добавления к этой записи.';

  @override
  String get activePositions => 'Активные позиции';

  @override
  String get sort => 'Сортировка';

  @override
  String get sortAmountDesc => 'Сумма: по убыванию';

  @override
  String get sortAmountAsc => 'Сумма: по возрастанию';

  @override
  String get sortNameAsc => 'Имя: А–Я';

  @override
  String get totalAssetsLent => 'Всего выдано';

  @override
  String get totalDebt => 'Всего долгов';

  @override
  String get totalBalance => 'Всего на балансе';

  @override
  String get itemNotFound => 'Запись не найдена';

  @override
  String get language => 'Язык';
}
