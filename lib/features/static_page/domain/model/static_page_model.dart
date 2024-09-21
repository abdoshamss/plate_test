// import 'dart:convert';
//
// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class StaticPageModel {
//   int? id;
//   String? title;
//   String? content;
//
//   StaticPageModel({
//     this.id,
//     this.title,
//     this.content,
//   });
//
//   StaticPageModel.fromMap(Map<String, dynamic> map) {
//     id = map['id'] != null ? map['id'] as int : null;
//     title = map['title'] != null ? map['title'] as String : null;
//     content = map['content'] != null ? map['content'] as String : null;
//   }
//
//   factory StaticPageModel.fromJson(String source) =>
//       StaticPageModel.fromMap(json.decode(source) as Map<String, dynamic>);
// }
//
// // Map<String, dynamic> toMap() {
// //   return <String, dynamic>{
// //     'id': id,
// //     'question': question,
// //     'like_count': like_count,
// //     'comment_count': comment_count,
// //   };
//
// class Question {
//   String? id;
//   String? question;
//   String? answer;
//   Question({
//   String? likeCount;
//   String? comment_coun;
//   QuestionModel({
//   this.id,
//   this.question,
//   this.answer,
//   });
//
//   factory Question.fromMap(Map<String, dynamic> map) {
//   return Question(
//   id: map['id'] != null ? (map['id'] as int).toString() : null,
//   question: map['question'] != null ? map['question'] as String : null,
//   answer: map['answer'] != null ? map['answer'] as String : null,
//   like_count:
//   map['like_count'] != null ? map['like_count']?.toString() : null,
//   comment_count: map['comment_count'] != null
//   ? map['comment_count']?.toString()
//       : null,
//   );
//   }
//
//   factory Question.fromJson(String source) =>
//   Question.fromMap(json.decode(source) as Map<String, dynamic>);
// }
// }
// class Questions {
//   List<Question>? questions;
//   Questions({
//     this.questions,
//   });
//
//   Questions.fromMap(Map<String, dynamic> map) {
//     questions = <Question>[];
//     if (map['questions'] != null) {
//       (map['questions'] as List).forEach((v) {
//         questions?.add(Question.fromMap(v));
//       });
//     }
//   }
//
//   factory Questions.fromJson(String source) =>
//       Questions.fromMap(json.decode(source) as Map<String, dynamic>);
// }
