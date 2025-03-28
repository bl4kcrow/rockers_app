enum AppUpdateStatus {
  noUpdate('No update available'),
  mandatory('Mandatory'),
  optional('Optional');

  const AppUpdateStatus(this.description);
  final String description;
}
