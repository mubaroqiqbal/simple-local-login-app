import 'package:dio/dio.dart';

Future<List<Job>> getJobs() async {
  try {
    final _dio = Dio();

    final response = await _dio.get(
      "https://jobs.github.com/positions.json?location=remote",
    );

    Iterable list = response.data;
    return list.map((model) => Job.fromJson(model)).toList();
  } on Exception catch (e) {
    throw e;
  }
}

class Job {
  String? title;
  String? company;

  Job({this.company, this.title});

  Job.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['company'] = this.company;
    return data;
  }
}
