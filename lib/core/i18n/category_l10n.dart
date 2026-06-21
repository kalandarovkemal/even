import '../../domain/entities/entry_category.dart';
import '../../l10n/app_localizations.dart';

extension CategoryL10n on AppLocalizations {
  String categoryTitle(EntryCategory category) => switch (category) {
        EntryCategory.lent => categoryLent,
        EntryCategory.debt => categoryDebt,
        EntryCategory.balance => categoryBalance,
      };

  String categoryBadge(EntryCategory category) => switch (category) {
        EntryCategory.lent => badgeOutbound,
        EntryCategory.debt => badgeInbound,
        EntryCategory.balance => badgeAvailable,
      };

  String categoryTotalLabel(EntryCategory category) => switch (category) {
        EntryCategory.lent => totalAssetsLent,
        EntryCategory.debt => totalDebt,
        EntryCategory.balance => totalBalance,
      };
}
