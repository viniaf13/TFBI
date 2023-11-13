enum WebUriEnum {
  assurancePay(
    'consumerdocuments/recurring%20payments%20terms%20and%20conditions.pdf',
  ),
  accountBill('/ConsumerDocuments/AccountBillTermsAndConditions.pdf'),
  privacyPolicy('privacy'),
  termsAndConditions('terms-conditions'),
  requiredNotices('required-notices');

  const WebUriEnum(this.path);

  final String path;
}
