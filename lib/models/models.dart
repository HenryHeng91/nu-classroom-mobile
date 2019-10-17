import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

//command generate json serializable flutter packages pub run build_runner build --delete-conflicting-outputs
@JsonSerializable()
class User{
  String id;
  String username;
  String profilePicture;
  String accessToken;
  String firstName;
  String lastName;
  String gender;
  String birthDate;
  String email;
  String phone;
  String address;
  String city;
  String country;
  String selfDescription;
  String educationLevel;
  String status;

  List<Classmate> classmates;

  List<Class> CreatedClasses;

  List<Class> JoinedClasses;

  String signUpDate;


  User(this.id, this.username, this.profilePicture, this.accessToken,
      this.firstName, this.lastName, this.gender, this.birthDate, this.email,
      this.phone, this.address, this.city, this.country, this.selfDescription,
      this.educationLevel, this.status, this.classmates, this.CreatedClasses,
      this.JoinedClasses, this.signUpDate);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class Classmate{
  String id;
  String username;
  String profilePicture;
  String firstName;
  String lastName;
  String gender;
  String birthDate;
  String email;
  String phone;
  String address;
  String city;
  String country;
  String selfDescription;
  String educationLevel;


  Classmate(this.id, this.username, this.profilePicture, this.firstName,
      this.lastName, this.gender, this.birthDate, this.email, this.phone,
      this.address, this.city, this.country, this.selfDescription,
      this.educationLevel);

  factory Classmate.fromJson(Map<String, dynamic> json) => _$ClassmateFromJson(json);
}

@JsonSerializable()
class Class{
  String id;
  String classTitle;
  String description;
  Instructor instructor;
  String url;
  Category category;
  String access;
  String status;
  int membersCount;
  Organization organization;
  String startDate;
  String endDate;
  String classStartDate;
  String classEndDate;
  List<int> classDays;
  String color;
  Background background;


  Class(this.id, this.classTitle, this.description, this.instructor, this.url,
      this.category, this.access, this.status, this.membersCount,
      this.organization, this.startDate, this.endDate, this.classStartDate,
      this.classEndDate, this.classDays, this.color, this.background);

  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);
}

@JsonSerializable()
class Instructor{
  final int id;
  final String profile_pic;
  final String first_name;
  final String last_name;
  final String gender;
  final String birth_date;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String country;
  final String self_description;
  final String education_level;
  final int status;
  final int role;

  Instructor(this.id, this.profile_pic, this.first_name, this.last_name, this.gender, this.birth_date, this.email, this.phone, this.address, this.city, this.country, this.self_description, this.education_level, this.status, this.role);

  factory Instructor.fromJson(Map<String, dynamic> json) => _$InstructorFromJson(json);
}

@JsonSerializable()
class Category{
  final int id;
  final String name;
  final String code;
  final String guid;

  Category(this.id, this.name, this.code, this.guid);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@JsonSerializable()
class Background{
  final int id;
  final String name;

  Background(this.id, this.name);

  factory Background.fromJson(Map<String, dynamic> json) => _$BackgroundFromJson(json);
}

@JsonSerializable()
class Organization{
  final int id;
  final String name;
  final String country;
  final String city;
  final String description;

  Organization(this.id, this.name, this.country, this.city, this.description);

  factory Organization.fromJson(Map<String, dynamic> json) => _$OrganizationFromJson(json);
}

@JsonSerializable()
class Post{
  final String id;
  final String detail;
  final Classmate user;
  final String classId;
  final String access;
  final String postType;
  final Classwork classwork;
  final String status;
  final int viewCount;
  final List<Classmate> viewers;
  final int likeCount;
  final List<Classmate> likers;
  final int commentCount;
  final String file;
  final String createDate;
  bool isAlreadyLike;

  Post(this.id, this.detail, this.user, this.classId, this.access, this.postType, this.status, this.viewCount, this.viewers, this.likeCount, this.likers, this.commentCount, this.file, this.classwork, this.createDate, this.isAlreadyLike);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@JsonSerializable()
class Classwork{
  final String id;
  final String title;
  final String description;

  Classwork(this.id, this.title, this.description);

  factory Classwork.fromJson(Map<String, dynamic> json) => _$ClassworkFromJson(json);
}

@JsonSerializable()
class CreatePost{
  String detail;
  String classId;
  String access;
  String postType;
  String startDate;
  String endDate;
  String examDuration;
  String showResultAt;
  int isAutoGrade;
  String fileId;
  CreateClasswork classwork;
  List<CreateClasswork> questions;

  CreatePost({this.detail, this.classId, this.access, this.postType,
      this.startDate, this.endDate, this.examDuration, this.showResultAt,
      this.isAutoGrade, this.classwork, this.questions,this.fileId});

  factory CreatePost.fromJson(Map<String, dynamic> json) => _$CreatePostFromJson(json);
  Map<String, dynamic> toJson() => _$CreatePostToJson(this);

}

@JsonSerializable()
class CreateClasswork{
  String questiongType;
  String title;
  String description;
  String fileId;


  CreateClasswork({this.questiongType, this.title, this.description,
      this.fileId});

  factory CreateClasswork.fromJson(Map<String, dynamic> json) => _$CreateClassworkFromJson(json);
  Map<String, dynamic> toJson() => _$CreateClassworkToJson(this);
}

@JsonSerializable()
class CreateAnswer{
  int correctAnswerIndex;
  List<CreateAnswerItem> items;


  CreateAnswer({this.correctAnswerIndex, this.items});

  factory CreateAnswer.fromJson(Map<String, dynamic> json) => _$CreateAnswerFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAnswerToJson(this);
}

@JsonSerializable()
class CreateAnswerItem{
  String answerDetail;

  CreateAnswerItem({this.answerDetail});

  factory CreateAnswerItem.fromJson(Map<String, dynamic> json) => _$CreateAnswerItemFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAnswerItemToJson(this);
}

@JsonSerializable()
class CreateClass{
  String classTitle;
  String description;
  String categoryId;
  String startDate;
  String endDate;
  String classStartTime;
  String classEndTime;
  String classDays;


  CreateClass({this.classTitle, this.description, this.categoryId,
      this.startDate, this.endDate, this.classStartTime, this.classEndTime,
      this.classDays});

  factory CreateClass.fromJson(Map<String, dynamic> json) => _$CreateClassFromJson(json);
  Map<String, dynamic> toJson() => _$CreateClassToJson(this);
}

@JsonSerializable()
class Comment{
  String id;
  Classmate user;
  String postId;
  String commentDetail;
  int likeCount;
  String fileId;

  Comment(this.id, this.user, this.postId, this.commentDetail, this.likeCount,
      this.fileId);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}