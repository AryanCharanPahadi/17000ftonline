// To parse this JSON data, do
//
//     final forms = formsFromMap(jsonString);

import 'dart:convert';

List<Forms> formsFromJson(String str) => List<Forms>.from(json.decode(str).map((x) => Forms.fromJson(x)));

String formsToJson(List<Forms> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forms {
    Forms({
        this.formId,
        this.formName,
    });

    String? formId;
    String? formName;

    factory Forms.fromJson(Map<String, dynamic> json) => Forms(
        formId: json["form_id"],
        formName: json["form_name"],
    );

    Map<String, dynamic> toJson() => {
        "form_id": formId,
        "form_name": formName,
    };
}
