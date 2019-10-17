// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['id'] as String,
      json['username'] as String,
      json['profilePicture'] as String,
      json['accessToken'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['gender'] as String,
      json['birthDate'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['city'] as String,
      json['country'] as String,
      json['selfDescription'] as String,
      json['educationLevel'] as String,
      json['status'] as String,
      (json['classmates'] as List)
          ?.map((e) =>
              e == null ? null : Classmate.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['CreatedClasses'] as List)
          ?.map((e) =>
              e == null ? null : Class.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['JoinedClasses'] as List)
          ?.map((e) =>
              e == null ? null : Class.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['signUpDate'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
      'accessToken': instance.accessToken,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'selfDescription': instance.selfDescription,
      'educationLevel': instance.educationLevel,
      'status': instance.status,
      'classmates': instance.classmates,
      'CreatedClasses': instance.CreatedClasses,
      'JoinedClasses': instance.JoinedClasses,
      'signUpDate': instance.signUpDate
    };

Classmate _$ClassmateFromJson(Map<String, dynamic> json) {
  return Classmate(
      json['id'] as String,
      json['username'] as String,
      json['profilePicture'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      json['gender'] as String,
      json['birthDate'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['city'] as String,
      json['country'] as String,
      json['selfDescription'] as String,
      json['educationLevel'] as String);
}

Map<String, dynamic> _$ClassmateToJson(Classmate instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'profilePicture': instance.profilePicture,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'gender': instance.gender,
      'birthDate': instance.birthDate,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'selfDescription': instance.selfDescription,
      'educationLevel': instance.educationLevel
    };

Class _$ClassFromJson(Map<String, dynamic> json) {
  return Class(
      json['id'] as String,
      json['classTitle'] as String,
      json['description'] as String,
      json['instructor'] == null
          ? null
          : Instructor.fromJson(json['instructor'] as Map<String, dynamic>),
      json['url'] as String,
      json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      json['access'] as String,
      json['status'] as String,
      json['membersCount'] as int,
      json['organization'] == null
          ? null
          : Organization.fromJson(json['organization'] as Map<String, dynamic>),
      json['startDate'] as String,
      json['endDate'] as String,
      json['classStartDate'] as String,
      json['classEndDate'] as String,
      (json['classDays'] as List)?.map((e) => e as int)?.toList(),
      json['color'] as String,
      json['background'] == null
          ? null
          : Background.fromJson(json['background'] as Map<String, dynamic>));
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'id': instance.id,
      'classTitle': instance.classTitle,
      'description': instance.description,
      'instructor': instance.instructor,
      'url': instance.url,
      'category': instance.category,
      'access': instance.access,
      'status': instance.status,
      'membersCount': instance.membersCount,
      'organization': instance.organization,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'classStartDate': instance.classStartDate,
      'classEndDate': instance.classEndDate,
      'classDays': instance.classDays,
      'color': instance.color,
      'background': instance.background
    };

Instructor _$InstructorFromJson(Map<String, dynamic> json) {
  return Instructor(
      json['id'] as int,
      json['profile_pic'] as String,
      json['first_name'] as String,
      json['last_name'] as String,
      json['gender'] as String,
      json['birth_date'] as String,
      json['email'] as String,
      json['phone'] as String,
      json['address'] as String,
      json['city'] as String,
      json['country'] as String,
      json['self_description'] as String,
      json['education_level'] as String,
      json['status'] as int,
      json['role'] as int);
}

Map<String, dynamic> _$InstructorToJson(Instructor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profile_pic': instance.profile_pic,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'gender': instance.gender,
      'birth_date': instance.birth_date,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'self_description': instance.self_description,
      'education_level': instance.education_level,
      'status': instance.status,
      'role': instance.role
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['id'] as int, json['name'] as String,
      json['code'] as String, json['guid'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'guid': instance.guid
    };

Background _$BackgroundFromJson(Map<String, dynamic> json) {
  return Background(json['id'] as int, json['name'] as String);
}

Map<String, dynamic> _$BackgroundToJson(Background instance) =>
    <String, dynamic>{'id': instance.id, 'name': instance.name};

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization(
      json['id'] as int,
      json['name'] as String,
      json['country'] as String,
      json['city'] as String,
      json['description'] as String);
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'city': instance.city,
      'description': instance.description
    };

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
      json['id'] as String,
      json['detail'] as String,
      json['user'] == null
          ? null
          : Classmate.fromJson(json['user'] as Map<String, dynamic>),
      json['classId'] as String,
      json['access'] as String,
      json['postType'] as String,
      json['status'] as String,
      json['viewCount'] as int,
      (json['viewers'] as List)
          ?.map((e) =>
              e == null ? null : Classmate.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['likeCount'] as int,
      (json['likers'] as List)
          ?.map((e) =>
              e == null ? null : Classmate.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['commentCount'] as int,
      json['file'] as String,
      json['classwork'] == null
          ? null
          : Classwork.fromJson(json['classwork'] as Map<String, dynamic>),
      json['createDate'] as String,
      json['isAlreadyLike'] as bool);
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'detail': instance.detail,
      'user': instance.user,
      'classId': instance.classId,
      'access': instance.access,
      'postType': instance.postType,
      'classwork': instance.classwork,
      'status': instance.status,
      'viewCount': instance.viewCount,
      'viewers': instance.viewers,
      'likeCount': instance.likeCount,
      'likers': instance.likers,
      'commentCount': instance.commentCount,
      'file': instance.file,
      'createDate': instance.createDate
    };

Classwork _$ClassworkFromJson(Map<String, dynamic> json) {
  return Classwork(json['id'] as String, json['title'] as String,
      json['description'] as String);
}

Map<String, dynamic> _$ClassworkToJson(Classwork instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description
    };

CreatePost _$CreatePostFromJson(Map<String, dynamic> json) {
  return CreatePost(
      detail: json['detail'] as String,
      classId: json['classId'] as String,
      access: json['access'] as String,
      postType: json['postType'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      examDuration: json['examDuration'] as String,
      showResultAt: json['showResultAt'] as String,
      isAutoGrade: json['isAutoGrade'] as int,
      classwork: json['classwork'] == null
          ? null
          : CreateClasswork.fromJson(json['classwork'] as Map<String, dynamic>),
      questions: (json['questions'] as List)
          ?.map((e) => e == null
              ? null
              : CreateClasswork.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      fileId: json['fileId'] as String);
}

Map<String, dynamic> _$CreatePostToJson(CreatePost instance) =>
    <String, dynamic>{
      'detail': instance.detail,
      'classId': instance.classId,
      'access': instance.access,
      'postType': instance.postType,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'examDuration': instance.examDuration,
      'showResultAt': instance.showResultAt,
      'isAutoGrade': instance.isAutoGrade,
      'fileId': instance.fileId,
      'classwork': instance.classwork,
      'questions': instance.questions
    };

CreateClasswork _$CreateClassworkFromJson(Map<String, dynamic> json) {
  return CreateClasswork(
      questiongType: json['questiongType'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fileId: json['fileId'] as String);
}

Map<String, dynamic> _$CreateClassworkToJson(CreateClasswork instance) =>
    <String, dynamic>{
      'questiongType': instance.questiongType,
      'title': instance.title,
      'description': instance.description,
      'fileId': instance.fileId
    };

CreateAnswer _$CreateAnswerFromJson(Map<String, dynamic> json) {
  return CreateAnswer(
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      items: (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : CreateAnswerItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CreateAnswerToJson(CreateAnswer instance) =>
    <String, dynamic>{
      'correctAnswerIndex': instance.correctAnswerIndex,
      'items': instance.items
    };

CreateAnswerItem _$CreateAnswerItemFromJson(Map<String, dynamic> json) {
  return CreateAnswerItem(answerDetail: json['answerDetail'] as String);
}

Map<String, dynamic> _$CreateAnswerItemToJson(CreateAnswerItem instance) =>
    <String, dynamic>{'answerDetail': instance.answerDetail};

CreateClass _$CreateClassFromJson(Map<String, dynamic> json) {
  return CreateClass(
      classTitle: json['classTitle'] as String,
      description: json['description'] as String,
      categoryId: json['categoryId'] as String,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      classStartTime: json['classStartTime'] as String,
      classEndTime: json['classEndTime'] as String,
      classDays: json['classDays'] as String);
}

Map<String, dynamic> _$CreateClassToJson(CreateClass instance) =>
    <String, dynamic>{
      'classTitle': instance.classTitle,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'classStartTime': instance.classStartTime,
      'classEndTime': instance.classEndTime,
      'classDays': instance.classDays
    };

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
      json['id'] as String,
      json['user'] == null
          ? null
          : Classmate.fromJson(json['user'] as Map<String, dynamic>),
      json['postId'] as String,
      json['commentDetail'] as String,
      json['likeCount'] as int,
      json['fileId'] as String);
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'postId': instance.postId,
      'CommentDetail': instance.commentDetail,
      'likeCount': instance.likeCount,
      'fileId': instance.fileId
    };
