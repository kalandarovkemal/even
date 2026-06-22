// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get currentPortfolio => 'Cartera actual';

  @override
  String get totalLabel => 'Total ';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get ratesOutdated => 'Las tasas podrían estar desactualizadas';

  @override
  String get categoryLent => 'Me deben';

  @override
  String get categoryDebt => 'Yo debo';

  @override
  String get categoryBalance => 'En mano';

  @override
  String get badgeOutbound => 'Saliente';

  @override
  String get badgeInbound => 'Entrante';

  @override
  String get badgeAvailable => 'Disponible';

  @override
  String get addNewItem => 'Añadir elemento';

  @override
  String get nameField => 'Nombre';

  @override
  String get nameHint => 'p. ej. Persona o cuenta';

  @override
  String get amountField => 'Importe';

  @override
  String get addItem => 'Añadir';

  @override
  String get selectCurrency => 'Seleccionar moneda';

  @override
  String get searchCurrencyHint => 'Buscar moneda o código';

  @override
  String get recent => 'Recientes';

  @override
  String get allCurrencies => 'Todas las monedas';

  @override
  String get results => 'Resultados';

  @override
  String get deleteItemTitle => '¿Eliminar elemento?';

  @override
  String get deleteItemMessage =>
      '¿Seguro que quieres eliminar este elemento? Esta acción no se puede deshacer.';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get editItem => 'Editar elemento';

  @override
  String get activeRecord => 'Registro activo';

  @override
  String get adjustAmount => 'Ajustar importe';

  @override
  String get subtract => 'Restar';

  @override
  String get add => 'Añadir';

  @override
  String get whereDoesItGo => '¿A dónde va este importe?';

  @override
  String get whereFrom => '¿De dónde?';

  @override
  String get moveToBalance => 'Mover al balance';

  @override
  String get moveFromBalance => 'Mover desde el balance';

  @override
  String get moveToBalanceSubtitle =>
      'Devuelve estos fondos a tus activos líquidos.';

  @override
  String get moveFromBalanceSubtitle =>
      'Descuenta estos fondos de tus activos líquidos.';

  @override
  String get targetWallet => 'Cartera destino';

  @override
  String get sourceWallet => 'Cartera origen';

  @override
  String get forgivenTitle => 'Perdonado / Perdido';

  @override
  String get forgivenSubtitle =>
      'El importe se descontará, pero no se registrará como ingreso.';

  @override
  String get noWallets => 'Aún no hay carteras de balance. Añade una primero.';

  @override
  String get saveTransfer => 'Guardar y transferir';

  @override
  String get helperSubtract =>
      'Introduce el importe que se ha devuelto o que debe descontarse del total.';

  @override
  String get helperAdd =>
      'Introduce el importe adicional para añadir a este registro.';

  @override
  String get activePositions => 'Posiciones activas';

  @override
  String get sort => 'Ordenar';

  @override
  String get sortAmountDesc => 'Importe: de mayor a menor';

  @override
  String get sortAmountAsc => 'Importe: de menor a mayor';

  @override
  String get sortNameAsc => 'Nombre: A a Z';

  @override
  String get totalAssetsLent => 'Total prestado';

  @override
  String get totalDebt => 'Deuda total';

  @override
  String get totalBalance => 'Balance total';

  @override
  String get itemNotFound => 'Elemento no encontrado';

  @override
  String get language => 'Idioma';

  @override
  String get fundFromWallet => '¿De dónde lo tomas?';

  @override
  String get fundToWallet => '¿A dónde va?';

  @override
  String get notFromBalance => 'No desde el balance';

  @override
  String get notToBalance => 'No al balance';

  @override
  String get informationalHint => 'Esta entrada no afectará tu total.';

  @override
  String get paywallTitle => 'Desbloquear Even';

  @override
  String get paywallSubtitle => 'Pago único. Tuyo para siempre.';

  @override
  String get paywallFeatures =>
      'Registros ilimitados · todas las monedas y tasas en vivo · todos los idiomas';

  @override
  String get unlock => 'Desbloquear';

  @override
  String get restore => 'Restaurar compras';

  @override
  String get freeLimitNote => 'Has alcanzado el límite gratuito de registros.';

  @override
  String get purchaseThanks => '¡Gracias! Todo está desbloqueado.';

  @override
  String get purchaseFailed => 'No se pudo completar la compra.';
}
