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

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('username', instance.username);
  writeNotNull('profilePicture', instance.profilePicture);
  writeNotNull('accessToken', instance.accessToken);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('gender', instance.gender);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('selfDescription', instance.selfDescription);
  writeNotNull('educationLevel', instance.educationLevel);
  writeNotNull('status', instance.status);
  writeNotNull('classmates', instance.classmates);
  writeNotNull('CreatedClasses', instance.CreatedClasses);
  writeNotNull('JoinedClasses', instance.JoinedClasses);
  writeNotNull('signUpDate', instance.signUpDate);
  return val;
}

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

Map<String, dynamic> _$ClassmateToJson(Classmate instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('username', instance.username);
  writeNotNull('profilePicture', instance.profilePicture);
  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  writeNotNull('gender', instance.gender);
  writeNotNull('birthDate', instance.birthDate);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('selfDescription', instance.selfDescription);
  writeNotNull('educationLevel', instance.educationLevel);
  return val;
}

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

Map<String, dynamic> _$ClassToJson(Class instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('classTitle', instance.classTitle);
  writeNotNull('description', instance.description);
  writeNotNull('instructor', instance.instructor);
  writeNotNull('url', instance.url);
  writeNotNull('category', instance.category);
  writeNotNull('access', instance.access);
  writeNotNull('status', instance.status);
  writeNotNull('membersCount', instance.membersCount);
  writeNotNull('organization', instance.organization);
  writeNotNull('startDate', instance.startDate);
  writeNotNull('endDate', instance.endDate);
  writeNotNull('classStartDate', instance.classStartDate);
  writeNotNull('classEndDate', instance.classEndDate);
  writeNotNull('classDays', instance.classDays);
  writeNotNull('color', instance.color);
  writeNotNull('background', instance.background);
  return val;
}

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

Map<String, dynamic> _$InstructorToJson(Instructor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('profile_pic', instance.profile_pic);
  writeNotNull('first_name', instance.first_name);
  writeNotNull('last_name', instance.last_name);
  writeNotNull('gender', instance.gender);
  writeNotNull('birth_date', instance.birth_date);
  writeNotNull('email', instance.email);
  writeNotNull('phone', instance.phone);
  writeNotNull('address', instance.address);
  writeNotNull('city', instance.city);
  writeNotNull('country', instance.country);
  writeNotNull('self_description', instance.self_description);
  writeNotNull('education_level', instance.education_level);
  writeNotNull('status', instance.status);
  writeNotNull('role', instance.role);
  return val;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(json['id'] as int, json['name'] as String,
      json['code'] as String, json['guid'] as String);
}

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('code', instance.code);
  writeNotNull('guid', instance.guid);
  return val;
}

Background _$BackgroundFromJson(Map<String, dynamic> json) {
  return Background(json['id'] as int, json['name'] as String);
}

Map<String, dynamic> _$BackgroundToJson(Background instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}

Organization _$OrganizationFromJson(Map<String, dynamic> json) {
  return Organization(
      json['id'] as int,
      json['name'] as String,
      json['country'] as String,
      json['city'] as String,
      json['description'] as String);
}

Map<String, dynamic> _$OrganizationToJson(Organization instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('country', instance.country);
  writeNotNull('city', instance.city);
  writeNotNull('description', instance.description);
  return val;
}

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
      json['file'] == null
          ? null
          : FileResponse.fromJson(json['file'] as Map<String, dynamic>),
      json['classwork'] == null
          ? null
          : CreateClasswork.fromJson(json['classwork'] as Map<String, dynamic>),
      json['createDate'] as String,
      json['isAlreadyLike'] as bool);
}

Map<String, dynamic> _$PostToJson(Post instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('detail', instance.detail);
  writeNotNull('user', instance.user);
  writeNotNull('classId', instance.classId);
  writeNotNull('access', instance.access);
  writeNotNull('postType', instance.postType);
  writeNotNull('classwork', instance.classwork);
  writeNotNull('status', instance.status);
  writeNotNull('viewCount', instance.viewCount);
  writeNotNull('viewers', instance.viewers);
  writeNotNull('likeCount', instance.likeCount);
  writeNotNull('likers', instance.likers);
  writeNotNull('commentCount', instance.commentCount);
  writeNotNull('file', instance.file);
  writeNotNull('createDate', instance.createDate);
  writeNotNull('isAlreadyLike', instance.isAlreadyLike);
  return val;
}

FileResponse _$FileResponseFromJson(Map<String, dynamic> json) {
  return FileResponse(
      json['id'] as int,
      json['display_name'] as String,
      json['description'] as String,
      json['source'] as String,
      json['file_extention'] as String,
      json['file_name'] as String);
}

Map<String, dynamic> _$FileResponseToJson(FileResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('display_name', instance.display_name);
  writeNotNull('description', instance.description);
  writeNotNull('source', instance.source);
  writeNotNull('file_extention', instance.file_extention);
  writeNotNull('file_name', instance.file_name);
  return val;
}

Classwork _$ClassworkFromJson(Map<String, dynamic> json) {
  return Classwork(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['examDuration'] as String,
      json['endDate'] as String);
}

Map<String, dynamic> _$ClassworkToJson(Classwork instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('examDuration', instance.examDuration);
  writeNotNull('endDate', instance.endDate);
  return val;
}

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

Map<String, dynamic> _$CreatePostToJson(CreatePost instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('detail', instance.detail);
  writeNotNull('classId', instance.classId);
  writeNotNull('access', instance.access);
  writeNotNull('postType', instance.postType);
  writeNotNull('startDate', instance.startDate);
  writeNotNull('endDate', instance.endDate);
  writeNotNull('examDuration', instance.examDuration);
  writeNotNull('showResultAt', instance.showResultAt);
  writeNotNull('isAutoGrade', instance.isAutoGrade);
  writeNotNull('fileId', instance.fileId);
  writeNotNull('classwork', instance.classwork);
  writeNotNull('questions', instance.questions);
  return val;
}

CreateClasswork _$CreateClassworkFromJson(Map<String, dynamic> json) {
  return CreateClasswork(
      questionId: json['questionId'] as String,
      questionType: json['questionType'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fileId: json['fileId'] as String,
      answer: json['answer'] == null
          ? null
          : CreateAnswer.fromJson(json['answer'] as Map<String, dynamic>),
      answers: (json['answers'] as List)
          ?.map((e) => e == null
              ? null
              : CreateAnswerItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      examDuration: json['examDuration'] as int,
      showResultAt: json['showResultAt'] as String,
      isAutoGrade: json['isAutoGrade'] as int,
      questions: (json['questions'] as List)
          ?.map((e) => e == null
              ? null
              : CreateClasswork.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$CreateClassworkToJson(CreateClasswork instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('questionId', instance.questionId);
  writeNotNull('questionType', instance.questionType);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('fileId', instance.fileId);
  writeNotNull('answer', instance.answer);
  writeNotNull('answers', instance.answers);
  writeNotNull('startDate', instance.startDate);
  writeNotNull('endDate', instance.endDate);
  writeNotNull('examDuration', instance.examDuration);
  writeNotNull('showResultAt', instance.showResultAt);
  writeNotNull('isAutoGrade', instance.isAutoGrade);
  writeNotNull('questions', instance.questions);
  return val;
}

CreateAnswer _$CreateAnswerFromJson(Map<String, dynamic> json) {
  return CreateAnswer(
      correctAnswerIndex: json['correctAnswerIndex'] as int,
      items: (json['items'] as List)
          ?.map((e) => e == null
              ? null
              : CreateAnswerItem.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      answerDetail: json['answerDetail'] as String);
}

Map<String, dynamic> _$CreateAnswerToJson(CreateAnswer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('correctAnswerIndex', instance.correctAnswerIndex);
  writeNotNull('answerDetail', instance.answerDetail);
  writeNotNull('items', instance.items);
  return val;
}

CreateAnswerItem _$CreateAnswerItemFromJson(Map<String, dynamic> json) {
  return CreateAnswerItem(answerDetail: json['answerDetail'] as String);
}

Map<String, dynamic> _$CreateAnswerItemToJson(CreateAnswerItem instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('answerDetail', instance.answerDetail);
  return val;
}

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

Map<String, dynamic> _$CreateClassToJson(CreateClass instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('classTitle', instance.classTitle);
  writeNotNull('description', instance.description);
  writeNotNull('categoryId', instance.categoryId);
  writeNotNull('startDate', instance.startDate);
  writeNotNull('endDate', instance.endDate);
  writeNotNull('classStartTime', instance.classStartTime);
  writeNotNull('classEndTime', instance.classEndTime);
  writeNotNull('classDays', instance.classDays);
  return val;
}

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

Map<String, dynamic> _$CommentToJson(Comment instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user', instance.user);
  writeNotNull('postId', instance.postId);
  writeNotNull('commentDetail', instance.commentDetail);
  writeNotNull('likeCount', instance.likeCount);
  writeNotNull('fileId', instance.fileId);
  return val;
}
