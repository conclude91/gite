import '../../user/models/user_model.dart';
import 'label_model.dart';
import 'pull_request_model.dart';
import 'reaction_model.dart';

class IssueModel {
  IssueModel({
    this.url,
    this.repositoryUrl,
    this.labelsUrl,
    this.commentsUrl,
    this.eventsUrl,
    this.htmlUrl,
    this.id,
    this.nodeId,
    this.number,
    this.title,
    this.user,
    this.labels,
    this.state,
    this.locked,
    this.assignee,
    this.assignees,
    this.milestone,
    this.comments,
    this.createdAt,
    this.updatedAt,
    this.closedAt,
    this.authorAssociation,
    this.activeLockReason,
    this.body,
    this.reactions,
    this.timelineUrl,
    this.performedViaGithubApp,
    this.score,
    this.draft,
    this.pullRequest,
  });

  factory IssueModel.fromJson(Map<String, dynamic> json) => IssueModel(
        url: json["url"],
        repositoryUrl: json["repository_url"],
        labelsUrl: json["labels_url"],
        commentsUrl: json["comments_url"],
        eventsUrl: json["events_url"],
        htmlUrl: json["html_url"],
        id: json["id"],
        nodeId: json["node_id"],
        number: json["number"],
        title: json["title"],
        user: UserModel.fromJson(json["user"]),
        labels: List<Label>.from(json["labels"].map((x) => Label.fromJson(x))),
        state: stateValues.map[json["state"]],
        locked: json["locked"],
        assignee: json["assignee"] == null
            ? null
            : UserModel.fromJson(json["assignee"]),
        assignees: List<UserModel>.from(
            json["assignees"].map((x) => UserModel.fromJson(x))),
        milestone: json["milestone"],
        comments: json["comments"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        closedAt: json["closed_at"],
        authorAssociation:
            authorAssociationValues.map[json["author_association"]],
        activeLockReason: json["active_lock_reason"],
        body: json["body"],
        reactions: Reactions.fromJson(json["reactions"]),
        timelineUrl: json["timeline_url"],
        performedViaGithubApp: json["performed_via_github_app"],
        score: json["score"],
        draft: json["draft"],
        pullRequest: json["pull_request"] == null
            ? null
            : PullRequest.fromJson(json["pull_request"]),
      );

  dynamic activeLockReason;
  UserModel? assignee;
  List<UserModel>? assignees;
  AuthorAssociation? authorAssociation;
  String? body;
  dynamic closedAt;
  int? comments;
  String? commentsUrl;
  DateTime? createdAt;
  bool? draft;
  String? eventsUrl;
  String? htmlUrl;
  int? id;
  List<Label>? labels;
  String? labelsUrl;
  bool? locked;
  dynamic milestone;
  String? nodeId;
  int? number;
  dynamic performedViaGithubApp;
  PullRequest? pullRequest;
  Reactions? reactions;
  String? repositoryUrl;
  double? score;
  StateIssue? state;
  String? timelineUrl;
  String? title;
  DateTime? updatedAt;
  String? url;
  UserModel? user;

  Map<String, dynamic> toJson() => {
        "url": url,
        "repository_url": repositoryUrl,
        "labels_url": labelsUrl,
        "comments_url": commentsUrl,
        "events_url": eventsUrl,
        "html_url": htmlUrl,
        "id": id,
        "node_id": nodeId,
        "number": number,
        "title": title,
        "user": user!.toJson(),
        "labels": List<dynamic>.from(labels!.map((x) => x.toJson())),
        "state": stateValues.reverse![state],
        "locked": locked,
        "assignee": assignee == null ? null : assignee!.toJson(),
        "assignees": List<dynamic>.from(assignees!.map((x) => x.toJson())),
        "milestone": milestone,
        "comments": comments,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "closed_at": closedAt,
        "author_association":
            authorAssociationValues.reverse![authorAssociation],
        "active_lock_reason": activeLockReason,
        "body": body,
        "reactions": reactions!.toJson(),
        "timeline_url": timelineUrl,
        "performed_via_github_app": performedViaGithubApp,
        "score": score,
        "draft": draft,
        "pull_request": pullRequest == null ? null : pullRequest!.toJson(),
      };
}

enum AuthorAssociation { owner, none, contributor, collaborator }

final authorAssociationValues = EnumValues({
  "COLLABORATOR": AuthorAssociation.collaborator,
  "CONTRIBUTOR": AuthorAssociation.contributor,
  "NONE": AuthorAssociation.none,
  "OWNER": AuthorAssociation.owner
});

enum StateIssue { open }

final stateValues = EnumValues({"open": StateIssue.open});
