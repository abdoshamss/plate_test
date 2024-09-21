abstract class SettingsStates {}

class SettingsInitial extends SettingsStates {}

class NotificationToggleSettingsLoading extends SettingsStates {}

class NotificationToggleSettingsSuccess extends SettingsStates {}

class NotificationToggleSettingsError extends SettingsStates {}

class GetWalletDataLoading extends SettingsStates {}

class GetWalletDataSuccess extends SettingsStates {
  String? balance;

  GetWalletDataSuccess({this.balance});
}

class GetWalletDataError extends SettingsStates {}

class ChargeWalletLoading extends SettingsStates {}

class ChargeWalletSuccess extends SettingsStates {}

class ChargeWalletError extends SettingsStates {}
