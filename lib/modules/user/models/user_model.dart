class UserModel {
  UserModel({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
    this.score,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: typeValues.map[json["type"]],
        siteAdmin: json["site_admin"],
        score: json["score"],
      );

  String? avatarUrl;
  String? eventsUrl;
  String? followersUrl;
  String? followingUrl;
  String? gistsUrl;
  String? gravatarId;
  String? htmlUrl;
  int? id;
  String? login;
  String? nodeId;
  String? organizationsUrl;
  String? receivedEventsUrl;
  String? reposUrl;
  double? score;
  bool? siteAdmin;
  String? starredUrl;
  String? subscriptionsUrl;
  Type? type;
  String? url;

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": typeValues.reverse![type],
        "site_admin": siteAdmin,
        "score": score,
      };
}

enum Type { user, organization }

final typeValues =
    EnumValues({"Organization": Type.organization, "User": Type.user});

class EnumValues<T> {
  EnumValues(this.map);

  Map<String, T> map;
  Map<T, String>? reverseMap;

  Map<T, String>? get reverse {
    return reverseMap ?? map.map((k, v) => MapEntry(v, k));
  }
}
