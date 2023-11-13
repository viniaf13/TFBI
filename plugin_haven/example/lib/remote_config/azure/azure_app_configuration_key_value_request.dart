class AzureAppConfigurationKeyValueRequest {
  AzureAppConfigurationKeyValueRequest({
    required this.etag,
    required this.key,
    required this.label,
    required this.contentType,
    required this.value,
    required this.tags,
    required this.locked,
    required this.lastModified,
  });
  String? etag;
  String? key;
  String? label;
  String? contentType;
  String? value;
  Tags? tags;
  bool? locked;
  String? lastModified;

  AzureAppConfigurationKeyValueRequest.fromJson(Map<String, dynamic> json) {
    etag = json['etag'];
    key = json['key'];
    label = json['label'];
    contentType = json['content_type'];
    value = json['value'];
    tags = Tags.fromJson(json['tags']);
    locked = json['locked'];
    lastModified = json['last_modified'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['etag'] = etag;
    data['key'] = key;
    data['label'] = label;
    data['content_type'] = contentType;
    data['value'] = value;
    data['tags'] = tags?.toJson();
    data['locked'] = locked;
    data['last_modified'] = lastModified;
    return data;
  }
}

class Tags {
  Tags();

  Tags.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }
}
