class License {
  License({
    this.key,
    this.name,
    this.spdxId,
    this.url,
    this.nodeId,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
        key: keyValues.map[json["key"]],
        name: nameValues.map[json["name"]],
        spdxId: spdxIdValues.map[json["spdx_id"]],
        url: json["url"],
        nodeId: nodeIdValues.map[json["node_id"]],
      );

  Key? key;
  Name? name;
  NodeId? nodeId;
  SpdxId? spdxId;
  String? url;

  Map<String, dynamic> toJson() => {
        "key": keyValues.reverse![key],
        "name": nameValues.reverse![name],
        "spdx_id": spdxIdValues.reverse![spdxId],
        "url": url,
        "node_id": nodeIdValues.reverse![nodeId],
      };
}

enum Key { apache20, gpl30, mit }

final keyValues = EnumValues(
    {"apache-2.0": Key.apache20, "gpl-3.0": Key.gpl30, "mit": Key.mit});

enum Name { apacheLicense20, gnuGeneralPublicLicenseV30, mitLicense }

final nameValues = EnumValues({
  "Apache License 2.0": Name.apacheLicense20,
  "GNU General Public License v3.0": Name.gnuGeneralPublicLicenseV30,
  "MIT License": Name.mitLicense
});

enum NodeId { mDc6TGljZW5zZTI, mDc6TGljZW5zZTk, mDc6TGljZW5zZTEz }

final nodeIdValues = EnumValues({
  "MDc6TGljZW5zZTI=": NodeId.mDc6TGljZW5zZTI,
  "MDc6TGljZW5zZTEz": NodeId.mDc6TGljZW5zZTEz,
  "MDc6TGljZW5zZTk=": NodeId.mDc6TGljZW5zZTk
});

enum SpdxId { apache20, gpl30, mit }

final spdxIdValues = EnumValues({
  "Apache-2.0": SpdxId.apache20,
  "GPL-3.0": SpdxId.gpl30,
  "MIT": SpdxId.mit
});

enum Visibility { public }

final visibilityValues = EnumValues({"public": Visibility.public});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  Map<T, String>? reverseMap;

  Map<T, String>? get reverse {
    return reverseMap ?? map.map((k, v) => MapEntry(v, k));
  }
}
