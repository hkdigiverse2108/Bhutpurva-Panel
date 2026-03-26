import 'dart:convert';

class DeleteRequestModel {
  final List<dynamic> deleteRequests;
  final State state;
  final int totalData;

  DeleteRequestModel({
    required this.deleteRequests,
    required this.state,
    required this.totalData,
  });

  factory DeleteRequestModel.fromRawJson(String str) =>
      DeleteRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteRequestModel(
        deleteRequests: List<dynamic>.from(
          json["deleteRequests"].map((x) => x),
        ),
        state: State.fromJson(json["state"]),
        totalData: json["totalData"],
      );

  Map<String, dynamic> toJson() => {
    "deleteRequests": List<dynamic>.from(deleteRequests.map((x) => x)),
    "state": state.toJson(),
    "totalData": totalData,
  };
}

class State {
  final int page;
  final dynamic totalPages;

  State({required this.page, required this.totalPages});

  factory State.fromRawJson(String str) => State.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory State.fromJson(Map<String, dynamic> json) =>
      State(page: json["page"], totalPages: json["totalPages"]);

  Map<String, dynamic> toJson() => {"page": page, "totalPages": totalPages};
}
