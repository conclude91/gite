class PullRequest {
  PullRequest({
    this.url,
    this.htmlUrl,
    this.diffUrl,
    this.patchUrl,
    this.mergedAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) => PullRequest(
        url: json["url"],
        htmlUrl: json["html_url"],
        diffUrl: json["diff_url"],
        patchUrl: json["patch_url"],
        mergedAt: json["merged_at"],
      );

  String? diffUrl;
  String? htmlUrl;
  dynamic mergedAt;
  String? patchUrl;
  String? url;

  Map<String, dynamic> toJson() => {
        "url": url,
        "html_url": htmlUrl,
        "diff_url": diffUrl,
        "patch_url": patchUrl,
        "merged_at": mergedAt,
      };
}
