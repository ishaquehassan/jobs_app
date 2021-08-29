class Job {
  String companyLogo;
  String title;
  String descp;

  Job(this.companyLogo, this.title, this.descp);

  static List<Job> get sampleData => [
        Job("assets/images/pocketsystems.png", "Flutter Developer Required",
            "Karachi, Pakistan"),
        Job("assets/images/google.png", "UX / UI Designer",
            "United State, America"),
        Job("assets/images/adobe.png", "Full Stack Developer",
            "Karachi, Pakistan"),
        Job("assets/images/jazz.png", "Sales Manager", "Karachi, Pakistan"),
        Job("assets/images/facebook.png", "Flutter Developer Required",
            "Karachi, Pakistan")
      ];

  Job.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    descp = json['descp'];
    companyLogo = json['companyLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['descp'] = this.descp;
    data['companyLogo'] = this.companyLogo;
    return data;
  }
}
