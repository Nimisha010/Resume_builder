/*class ResumeTemplate {
  final String templateId;
  final String templateName;
  final bool atsCompliant;
  final List<Section> sections;

  ResumeTemplate({
    required this.templateId,
    required this.templateName,
    required this.atsCompliant,
    required this.sections,
  });

  factory ResumeTemplate.fromJson(Map<String, dynamic> json) {
    List<Section> sectionsList = (json['sections'] as List)
        .map((section) => Section.fromJson(section))
        .toList();

    return ResumeTemplate(
      templateId: json['template_id'],
      templateName: json['template_name'],
      atsCompliant: json['ats_compliant'],
      sections: sectionsList,
    );
  }
}

class Section {
  final String sectionId;
  final String title;
  final List<String> fields;

  Section({
    required this.sectionId,
    required this.title,
    required this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionId: json['section_id'],
      title: json['title'],
      fields: List<String>.from(json['fields']),
    );
  }
}
*/
/*
class ResumeTemplate {
  final String templateId;
  final String templateName;
  final bool atsCompliant;
  final List<Section> sections;

  ResumeTemplate({
    required this.templateId,
    required this.templateName,
    required this.atsCompliant,
    required this.sections,
  });

  factory ResumeTemplate.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonData = json['json_data'] ?? {};
    print("🔥 Parsing Template JSON: $jsonData");
    List<Section> sectionsList = (json['sections'] as List?)
            ?.map(
                (section) => Section.fromJson(section as Map<String, dynamic>))
            .toList() ??
        [];
    String templateId = jsonData['template_id'] ?? "Unknown ID";
    String templateName = jsonData['template_name'] ?? "Untitled";
    bool atsCompliant = jsonData['ats_compliant'] ?? false;

    print(
        "✅ Parsed Template -> ID: $templateId, Name: $templateName, ATS: $atsCompliant, Sections: ${sectionsList.length}");

    return ResumeTemplate(
      templateId:
          json['template_id'] ?? "Unknown ID", // ✅ Fix: Handle missing values
      templateName: json['template_name'] ?? "Untitled",
      atsCompliant:
          json['ats_compliant'] ?? false, // ✅ Fix: Default false if missing
      sections: sectionsList,
    );
  }
}

class Section {
  final String sectionId;
  final String title;
  final List<String> fields;

  Section({
    required this.sectionId,
    required this.title,
    required this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionId: json['section_id'] ?? "Unknown Section",
      title: json['title'] ?? "Untitled Section",
      fields: (json['fields'] as List?)?.map((f) => f.toString()).toList() ??
          [], // ✅ Fix: Default to empty list
    );
  }
}
*/
/*correct one

class ResumeTemplate {
  final String templateId;
  final String templateName;
  final bool atsCompliant;
  final List<Section> sections;

  ResumeTemplate({
    required this.templateId,
    required this.templateName,
    required this.atsCompliant,
    required this.sections,
  });

  factory ResumeTemplate.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonData = json['json_data'] ?? {};
    print("🔥 Parsing Template JSON: $jsonData");
    List<Section> sectionsList = [];
    if (jsonData.containsKey('sections') && jsonData['sections'] is List) {
      sectionsList = (jsonData['sections'] as List)
          .where((section) => section != null) // ✅ Remove null values
          .map((section) => Section.fromJson(section as Map<String, dynamic>))
          .toList();
    }
    String templateId = jsonData['template_id'] ?? "Unknown ID";
    String templateName = jsonData['template_name'] ?? "Untitled";
    bool atsCompliant = jsonData['ats_compliant'] ?? false;

    print(
        "✅ Parsed Template -> ID: $templateId, Name: $templateName, ATS: $atsCompliant, Sections: ${sectionsList.length}");

    return ResumeTemplate(
      templateId:
          json['template_id'] ?? "Unknown ID", // ✅ Fix: Handle missing values
      templateName: json['template_name'] ?? "Untitled",
      atsCompliant:
          json['ats_compliant'] ?? false, // ✅ Fix: Default false if missing
      sections: sectionsList,
    );
  }
}

class Section {
  final String sectionId;
  final String title;
  final List<String> fields;

  Section({
    required this.sectionId,
    required this.title,
    required this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionId: json['section_id'] ?? "Unknown Section",
      title: json['title'] ?? "Untitled Section",
      fields: (json['fields'] as List?)
              ?.where((f) => f != null)
              .map((f) => f.toString())
              .toList() ??
          [], // ✅ Fix: Remove null values
    );
  }
}
*/

class ResumeTemplate {
  final String id;
  final String templateName;
  final String templateId;
  final Map<String, dynamic> jsonData;
  final bool atsCompliant;
  final List<Section> sections;

  ResumeTemplate({
    required this.id,
    required this.templateName,
    required this.templateId,
    required this.jsonData,
    required this.atsCompliant,
    required this.sections,
  });

  factory ResumeTemplate.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> jsonData = json['json_data'] ?? {};
    print("🔥 Parsing Template JSON: $jsonData");

    List<Section> sectionsList = [];
    if (jsonData.containsKey('sections') && jsonData['sections'] is List) {
      sectionsList = (jsonData['sections'] as List)
          .where((section) => section != null) // ✅ Remove null values
          .map((section) => Section.fromJson(section as Map<String, dynamic>))
          .toList();
    }

    return ResumeTemplate(
      id: json['id'] ?? "", // ✅ Fix: Ensure `id` is parsed
      templateName:
          jsonData['template_name'] ?? "Untitled", // ✅ Extract from `json_data`
      templateId:
          jsonData['template_id'] ?? "No ID", // ✅ Extract from `json_data`
      jsonData: jsonData, // ✅ Store full JSON data
      atsCompliant:
          jsonData['ats_compliant'] ?? false, // ✅ Default to false if missing
      sections: sectionsList,
    );
  }
}

class Section {
  final String sectionId;
  final String title;
  final List<String> fields;

  Section({
    required this.sectionId,
    required this.title,
    required this.fields,
  });

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionId: json['section_id'] ?? "Unknown Section",
      title: json['title'] ?? "Untitled Section",
      fields: (json['fields'] as List?)
              ?.where((f) => f != null)
              .map((f) => f.toString())
              .toList() ??
          [], // ✅ Fix: Remove null values
    );
  }
}
