class MultiMessageCreateMain {
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strNoImage = '';
  var strQuestionType = ''; //
  var strEx4 = '';
  var strTF = '';
  var strMatchPicture = ''; //
  var strMatchText = ''; //
  var strMultiEx4 = ''; //
  var strHintDescription = '';
  var strWarnTitle = '';
  var strWarnImage = '';
  var strWarnType = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '새로운 챕터';
      strHintTitle = '제목을 입력하세요';
      strNoImage = '사진없음';
      strQuestionType = '문제유형'; //
      strEx4 = '01. 선택형4';
      strTF = '02. 참/거짓';
      strMatchPicture = '03. 그림매칭'; //매칭형4==>그림매칭
      strMatchText = '04. 문자매칭';
      strMultiEx4 = '05. 다중선택4';
      strHintDescription = '설명을 입력하세요';
      strWarnTitle = '제목을 입력하세요';
      strWarnImage = '사진을 선택하세요';
      strWarnType = '문제 유형을 선택하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'New Chapter';
      strHintTitle = 'Please input the title';
      strNoImage = 'No Image';
      strQuestionType = 'Question Type'; //
      strEx4 = '01. EX4';
      strTF = '02. T/F';
      strMatchPicture = '03. Picture Match';//Match4=>Match4
      strMatchText = '04. Text Match';
      strMultiEx4 = '05. Multi EX4';
      strHintDescription = 'Please input the description';
      strWarnTitle = 'Please input the title';
      strWarnImage = 'Please select a picture';
      strWarnType = 'Please select question type';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '新主题';
      strHintTitle = '请输入主题';
      strNoImage = '没有图片';
      strQuestionType = '题目类型'; //题目类型
      strEx4 = '01. 单选题'; //01. 单选题
      strTF = '02. 对错题';
      strMatchPicture = '03. 图片连线'; //그림매칭, 连线题
      strMatchText = '04. 文字连线'; //문자매칭
      strMultiEx4 = '05. 多选题';
      strHintDescription = '请输入内容';
      strWarnTitle = '请输入主题';
      strWarnImage = '请选择图片';
      strWarnType = '选择题目种类';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageCreateEx2 {
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strNoImage = '';
  var strTrue = '';
  var strFalse = '';
  var strHintInputAnswer = '';
  var strWarnTitle = '';
  var strWarnInputAnswer = '';
  var strWarnImage = '';
  var strWarnSelectAnswer = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '새로운 질문';
      strHintTitle = '질문을 입력하세요';
      strNoImage = '사진없음\n(선택사항)';
      strTrue = '진실';
      strFalse = '거짓';
      strHintInputAnswer = '정답을 입력하세요';
      strWarnTitle = '질문을 입력하세요';
      strWarnInputAnswer = '정답을 입력하세요';
      strWarnImage = '사진을 선택하세요';
      strWarnSelectAnswer = '정답을 선택하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'New Question';
      strHintTitle = 'Please input the question';
      strNoImage = 'No Image\n(optional)';
      strTrue = 'True';
      strFalse = 'False';
      strHintInputAnswer = 'Please input the correct answer';
      strWarnTitle = 'Please input the question';
      strWarnInputAnswer = 'Please input the correct answer';
      strWarnImage = 'Please select a picture';
      strWarnSelectAnswer = 'Please select correct answer';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '新问题';
      strHintTitle = '请输入问题';
      strNoImage = '没有图片';
      strTrue = '对';
      strFalse = '错';
      strHintInputAnswer = '请输入正确答案';
      strWarnTitle = '请输入问题';
      strWarnInputAnswer = '请输入正确答案';
      strWarnImage = '请选择图片';
      strWarnSelectAnswer = '请选择正确答案';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageCreateEx4 {
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strNoImage = '';
  var strEx = '';
  var strHintInputEx = '';
  var strWarnTitle = '';
  var strWarnImage = '';
  var strWarnEx1 = '';
  var strWarnEx2 = '';
  var strWarnEx3 = '';
  var strWarnEx4 = '';
  var strWarnSelectAnswer = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '새로운 질문';
      strHintTitle = '질문을 입력하세요';
      strNoImage = '사진없음\n(선택사항)';
      strEx = '예시';
      strHintInputEx = '예시를 입력하세요';
      strWarnTitle = '질문을 입력하세요';
      strWarnImage = '사진을 선택하세요';
      strWarnEx1 = '1번째 예시를 입력하세요';
      strWarnEx2 = '2번째 예시를 입력하세요';
      strWarnEx3 = '3번째 예시를 입력하세요';
      strWarnEx4 = '4번째 예시를 입력하세요';
      strWarnSelectAnswer = '정답을 선택하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'New Question';
      strHintTitle = 'Please input the question';
      strNoImage = 'No Image\n(optional)';
      strEx = 'ex';
      strHintInputEx = 'Please input the example';
      strWarnTitle = 'Please input the question';
      strWarnImage = 'Please select a picture';
      strWarnEx1 = 'Please input the 1st example';
      strWarnEx2 = 'Please input the 2nd example';
      strWarnEx3 = 'Please input the 3rd example';
      strWarnEx4 = 'Please input the 4th example';
      strWarnSelectAnswer = 'Please select correct answer';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '新问题';
      strHintTitle = '请输入问题';
      strNoImage = '没有图片';
      strEx = '示例';
      strHintInputEx = '请输入示例';
      strWarnTitle = '请输入问题';
      strWarnImage = '请选择图片';
      strWarnEx1 = '请输入第一个示例';
      strWarnEx2 = '请输入第二个示例';
      strWarnEx3 = '请输入第三个示例';
      strWarnEx4 = '请输入第四个示例';
      strWarnSelectAnswer = '请输入正确答案';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageCreateMatch4 {
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strNoImage = '';
  var strEx = '';
  var strWarnTitle = '';
  var strWarnImage1 = '';
  var strWarnImage2 = '';
  var strWarnImage3 = '';
  var strWarnImage4 = '';
  var strWarnEx1 = '';
  var strWarnEx2 = '';
  var strWarnEx3 = '';
  var strWarnEx4 = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '새로운 질문';
      strHintTitle = '질문을 입력하세요';
      strNoImage = '사진없음';
      strEx = '예시';
      strWarnTitle = '질문을 입력하세요';
      strWarnImage1 = '사진1 선택하세요';
      strWarnImage2 = '사진2 선택하세요';
      strWarnImage3 = '사진3 선택하세요';
      strWarnImage4 = '사진4 선택하세요';
      strWarnEx1 = '1번째 예시를 입력하세요';
      strWarnEx2 = '2번째 예시를 입력하세요';
      strWarnEx3 = '3번째 예시를 입력하세요';
      strWarnEx4 = '4번째 예시를 입력하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'New Question';
      strHintTitle = 'Please input the question';
      strNoImage = 'No Image';
      strEx = 'ex';
      strWarnTitle = 'Please input the question';
      strWarnImage1 = 'Please select the 1st picture';
      strWarnImage2 = 'Please select the 2nd picture';
      strWarnImage3 = 'Please select the 3rd picture';
      strWarnImage4 = 'Please select the 4th picture';
      strWarnEx1 = 'Please input the 1st example';
      strWarnEx2 = 'Please input the 2nd example';
      strWarnEx3 = 'Please input the 3rd example';
      strWarnEx4 = 'Please input the 4th example';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '新问题';
      strHintTitle = '请输入问题';
      strNoImage = '没有图片';
      strEx = '示例';
      strWarnTitle = '请输入问题';
      strWarnImage1 = '请选择第一张图片';
      strWarnImage2 = '请选择第二张图片';
      strWarnImage3 = '请选择第三张图片';
      strWarnImage4 = '请选择第四张图片';
      strWarnEx1 = '请输入第一个示例';
      strWarnEx2 = '请输入第二个示例';
      strWarnEx3 = '请输入第三个示例';
      strWarnEx4 = '请输入第四个示例';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageCreateMatchText {
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strNoImage = '';
  var strEx = '';
  var strWarnTitle = '';
  var strWarnEx1A = '';
  var strWarnEx2A = '';
  var strWarnEx3A = '';
  var strWarnEx4A = '';
  var strWarnEx1B = '';
  var strWarnEx2B = '';
  var strWarnEx3B = '';
  var strWarnEx4B = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '새로운 질문';
      strHintTitle = '질문을 입력하세요';
      strNoImage = '사진없음';
      strEx = '예시';
      strWarnTitle = '질문을 입력하세요';
      strWarnEx1A = '예시(1-A)를 입력하세요';
      strWarnEx2A = '예시(2-A)를 입력하세요';
      strWarnEx3A = '예시(3-A)를 입력하세요';
      strWarnEx4A = '예시(4-A)를 입력하세요';
      strWarnEx1B = '예시(1-B)를 입력하세요';
      strWarnEx2B = '예시(2-B)를 입력하세요';
      strWarnEx3B = '예시(3-B)를 입력하세요';
      strWarnEx4B = '예시(4-B)를 입력하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'New Question';
      strHintTitle = 'Please input the question';
      strNoImage = 'No Image';
      strEx = 'ex';
      strWarnTitle = 'Please input the question';
      strWarnEx1A = 'Please input the example(1-A)';
      strWarnEx2A = 'Please input the example(2-A)';
      strWarnEx3A = 'Please input the example(3-A)';
      strWarnEx4A = 'Please input the example(4-A)';
      strWarnEx1B = 'Please input the example(1-B)';
      strWarnEx2B = 'Please input the example(2-B)';
      strWarnEx3B = 'Please input the example(3-B)';
      strWarnEx4B = 'Please input the example(4-B)';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '新问题';
      strHintTitle = '请输入问题';
      strNoImage = '没有图片';
      strEx = '示例';
      strWarnTitle = '请输入问题';
      strWarnEx1A = '请输入第一个示例(A)';
      strWarnEx2A = '请输入第二个示例(A)';
      strWarnEx3A = '请输入第三个示例(A)';
      strWarnEx4A = '请输入第四个示例(A)';
      strWarnEx1B = '请输入第一个示例(B)';
      strWarnEx2B = '请输入第二个示例(B)';
      strWarnEx3B = '请输入第三个示例(B)';
      strWarnEx4B = '请输入第四个示例(B)';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageDetail {
  var strAppBarTitle = '';
  var strAddSub = '';
  var strListSub = '';
  var strDelete = '';
  var strWarnAdd = '';
  var strWarnMessage = '';
  var strQType = '';
  var strEx4 = '';
  var strTF = '';
  var strMatchPicture = ''; //strMatch4/strMatchPicture
  var strMatchText = '';
  var strMultiEx4 = '';
  var strQCnt = '';
  var strTeacherUid = '';
  var strTestCode = '';
  var strCopy = '';
  var strWarnDelete = '';
  var strNo = '';
  var strYes = '';
  var strOk = '';


  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '주제';
      strAddSub = '질문 추가';
      strListSub = '질문 리스트';
      strDelete = '전체삭제';
      strWarnAdd = '질문 추가/삭제 불가 - 시험본 학생있음';
      strWarnMessage = '알림';
      strQType = '문제형식';
      strEx4 = '선택형4';
      strTF = '참/거짓';
      strMatchPicture = '그림매칭';
      strMatchText = '문자매칭';
      strMultiEx4 = '다중선택4';
      strQCnt = '문항수';
      strTeacherUid = '선생님코드';
      strTestCode = '시험코드';
      strCopy = '복사 (선생님코드&시험코드)';
      strWarnDelete = '해당 챕터 및 하위 질문 전체가 삭제됩니다. 삭제후 복구 불가능합니다';
      strNo = '취소';
      strYes = '삭제';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'Title';
      strAddSub = 'Add sub';
      strListSub = 'List sub';
      strDelete = 'Delete';
      strWarnAdd = "No more add/delete questions due to student's test results";
      strWarnMessage = 'Notifications';
      strQType = 'Questions Type';
      strEx4 = 'EX4';
      strTF = 'T/F';
      strMatchPicture = 'Picture Match';
      strMatchText = 'Text Match';
      strMultiEx4 = 'Multi EX4';
      strQCnt = 'Questions';
      strTeacherUid = 'Teacher UID';
      strTestCode = 'Test Code';
      strCopy = 'Copy (Teacher UID&Test Code)';
      strWarnDelete = 'This chapter will be removed with sub questions. This action cannot be undone';
      strNo = 'No';
      strYes = 'Yes';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '主题';
      strAddSub = '添加问题';
      strListSub = '查看问题';
      strDelete = '删除';
      strWarnAdd = '题目使用中, 不能修改内容';
      strWarnMessage = '提示';
      strQType = '类型';
      strEx4 = '选择题';
      strTF = '对错题';
      strMatchPicture = '图片连线'; //
      strMatchText = '文字连线';
      strMultiEx4 = '多选题';
      strQCnt = '问题数量';
      strTeacherUid = '教师ID';
      strTestCode = '题目代码';
      strCopy = '复制 (教师ID和问题代码)';
      strWarnDelete = '本主题将会和其他子题目一起被删除, 此操作无法撤销';
      strNo = '否';
      strYes = '是';
      strOk = '确认';
    }
  }
}

class MultiMessageHome {
  static const version = '0.6.0';
  var strTeacher = '';
  var strParents = '';
  var strStudent = '';
  var strOther = '';
  var strVersion = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strTeacher = '당신은 선생님입니다';
      strParents = '당신은 학부모님입니다';
      strStudent = '당신은 학생입니다';
      strOther = '안녕하세요~';
      strVersion = '버전 $version';
    }
    else if(type == 'English') {
      strTeacher = 'You are a teacher';
      strParents = 'You are parents';
      strStudent = 'You are a student';
      strOther = 'How are you~';
      strVersion = 'Version $version';
    }
    else if(type == 'Chinese') {
      strTeacher = '你是老师';
      strParents = '你是家长';
      strStudent = '你是学生';
      strOther = '你好~';
      strVersion = '版本 $version';
    }
  }
}

class MultiMessageInform {
  var strAppBarTitle = '';
  var strLang = '';
  var strUserType = '';
  var strApply = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '사용자 정보 선택';
      strLang = '사용자 언어';
      strUserType = '사용자 유형';
      strApply = '적용';
    }
    else if(type == 'English') {
      strAppBarTitle = 'User Information';
      strLang = 'User Lang';
      strUserType = 'User Type';
      strApply = 'Apply';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '用户信息';
      strLang = '语言';
      strUserType = '种类';
      strApply = '应用';
    }
  }
}

class MultiMessageListEx2 {
  var strModify = '';
  var strDelete = '';
  var strNoData = '';
  var strNoList = '';
  var strWarnMessage = '';
  var strWarnDelete = '';
  var strNo = '';
  var strYes = '';
  var strTrue = '';
  var strFalse = '';
  var strAnswer = '';
  var strStudentCnt = '';
  var strNoOne = '';
  var strMissMatching = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strModify = '수정';
      strDelete = '삭제';
      strNoData = '데이터 없음';
      strNoList = '리스트 없음';
      strWarnMessage = '알림';
      strWarnDelete = '해당 질문을 삭제합니다. 삭제후 복구 불가능합니다';
      strNo = '취소';
      strYes = '삭제';
      strTrue = '진실';
      strFalse = '거짓';
      strAnswer = '정답';
      strStudentCnt = '학생수';
      strNoOne = '아무도 테스트하지 않았습니다';
      strMissMatching = '문항수 오류(결과수:';
    }
    else if(type == 'English') {
      strModify = 'Modify';
      strDelete = 'Delete';
      strNoData = 'No data';
      strNoList = 'No list page';
      strWarnMessage = 'Notifications';
      strWarnDelete = 'This question will be removed. This action cannot be undone';
      strNo = 'No';
      strYes = 'Yes';
      strTrue = 'True';
      strFalse = 'False';
      strAnswer = 'Correct';
      strStudentCnt = 'Total Students';
      strNoOne = 'No one test yet';
      strMissMatching = 'Miss matching (Result:';
    }
    else if(type == 'Chinese') {
      strModify = '更改';
      strDelete = '删除';
      strNoData = '无数据';
      strNoList = '页数';
      strWarnMessage = '提示';
      strWarnDelete = '本题目将被删除, 此操作无法撤销.';
      strNo = '否';
      strYes = '是';
      strTrue = '对';
      strFalse = '错';
      strAnswer = '正确';
      strStudentCnt = '完成人数';
      strNoOne = '无人参与测试';
      strMissMatching = '匹配错屋(结果:';
    }
  }
}

class MultiMessageListEx4 {
  var strModify = '';
  var strDelete = '';
  var strNoData = '';
  var strNoList = '';
  var strWarnMessage = '';
  var strWarnDelete = '';
  var strNo = '';
  var strYes = '';
  var strEx = '';
  var strStudentCnt = '';
  var strNoOne = '';
  var strMissMatching = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strModify = '수정';
      strDelete = '삭제';
      strNoData = '데이터 없음';
      strNoList = '리스트 없음';
      strWarnMessage = '알림';
      strWarnDelete = '해당 질문을 삭제합니다. 삭제후 복구 불가능합니다';
      strNo = '취소';
      strYes = '삭제';
      strEx = '예시';
      strStudentCnt = '학생수';
      strNoOne = '아무도 테스트하지 않았습니다';
      strMissMatching = '문항수 오류(결과수:';
    }
    else if(type == 'English') {
      strModify = 'Modify';
      strDelete = 'Delete';
      strNoData = 'No data';
      strNoList = 'No list page';
      strWarnMessage = 'Notifications';
      strWarnDelete = 'This question will be removed. This action cannot be undone';
      strNo = 'No';
      strYes = 'Yes';
      strEx = 'ex';
      strStudentCnt = 'Total Student';
      strNoOne = 'No one test yet';
      strMissMatching = 'Miss matching (Result:';
    }
    else if(type == 'Chinese') {
      strModify = '更改';
      strDelete = '删除';
      strNoData = '无数据';
      strNoList = '页数';
      strWarnMessage = '提示';
      strWarnDelete = '本题目将被删除, 此操作无法撤销.';
      strNo = '否';
      strYes = '是';
      strEx = '示例';
      strStudentCnt = '完成人数';
      strNoOne = '无人参与测试';
      strMissMatching = '匹配错屋(结果:';
    }
  }
}

class MultiMessageListMatch4 {
  var strModify = '';
  var strDelete = '';
  var strNoData = '';
  var strNoList = '';
  var strWarnMessage = '';
  var strWarnDelete = '';
  var strNo = '';
  var strYes = '';
  var strEx = '';
  var strStudentCnt = '';
  var strNoOne = '';
  var strMissMatching = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strModify = '수정';
      strDelete = '삭제';
      strNoData = '데이터 없음';
      strNoList = '리스트 없음';
      strWarnMessage = '알림';
      strWarnDelete = '해당 질문을 삭제합니다. 삭제후 복구 불가능합니다';
      strNo = '취소';
      strYes = '삭제';
      strEx = '예시';
      strStudentCnt = '학생수';
      strNoOne = '아무도 테스트하지 않았습니다';
      strMissMatching = '문항수 오류(결과수:';
    }
    else if(type == 'English') {
      strModify = 'Modify';
      strDelete = 'Delete';
      strNoData = 'No data';
      strNoList = 'No list page';
      strWarnMessage = 'Notifications';
      strWarnDelete = 'This question will be removed. This action cannot be undone';
      strNo = 'No';
      strYes = 'Yes';
      strEx = 'ex';
      strStudentCnt = 'Total Student';
      strNoOne = 'No one test yet';
      strMissMatching = 'Miss matching (Result:';
    }
    else if(type == 'Chinese') {
      strModify = '更改';
      strDelete = '删除';
      strNoData = '无数据';
      strNoList = '页数';
      strWarnMessage = '提示';
      strWarnDelete = '本题目将被删除, 此操作无法撤销.';
      strNo = '否';
      strYes = '是';
      strEx = '示例';
      strStudentCnt = '完成人数';
      strNoOne = '无人参与测试';
      strMissMatching = '匹配错屋(结果:';
    }
  }
}

class MultiMessageListMatchText {
  var strModify = '';
  var strDelete = '';
  var strNoData = '';
  var strNoList = '';
  var strWarnMessage = '';
  var strWarnDelete = '';
  var strNo = '';
  var strYes = '';
  var strEx = '';
  var strStudentCnt = '';
  var strNoOne = '';
  var strMissMatching = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strModify = '수정';
      strDelete = '삭제';
      strNoData = '데이터 없음';
      strNoList = '리스트 없음';
      strWarnMessage = '알림';
      strWarnDelete = '해당 질문을 삭제합니다. 삭제후 복구 불가능합니다';
      strNo = '취소';
      strYes = '삭제';
      strEx = '예시';
      strStudentCnt = '학생수';
      strNoOne = '아무도 테스트하지 않았습니다';
      strMissMatching = '문항수 오류(결과수:';
    }
    else if(type == 'English') {
      strModify = 'Modify';
      strDelete = 'Delete';
      strNoData = 'No data';
      strNoList = 'No list page';
      strWarnMessage = 'Notifications';
      strWarnDelete = 'This question will be removed. This action cannot be undone';
      strNo = 'No';
      strYes = 'Yes';
      strEx = 'ex';
      strStudentCnt = 'Total Student';
      strNoOne = 'No one test yet';
      strMissMatching = 'Miss matching (Result:';
    }
    else if(type == 'Chinese') {
      strModify = '更改';
      strDelete = '删除';
      strNoData = '无数据';
      strNoList = '页数';
      strWarnMessage = '提示';
      strWarnDelete = '本题目将被删除, 此操作无法撤销.';
      strNo = '否';
      strYes = '是';
      strEx = '示例';
      strStudentCnt = '完成人数';
      strNoOne = '无人参与测试';
      strMissMatching = '匹配错屋(结果:';
    }
  }
}

class MultiMessageManage {
//  _multiLang
  var strManagement = '';
  var strChapters = '';
  var strQuestions = '';
  var strStudents = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strManagement = '관리';
      strChapters = '챕터수';
      strQuestions = '문제수';
      strStudents = '학생수';
    }
    else if(type == 'English') {
      strManagement = 'Management';
      strChapters = 'Chapters';
      strQuestions = 'Questions';
      strStudents = 'Students';
    }
    else if(type == 'Chinese') {
      strManagement = '管理';
      strChapters = '主题';
      strQuestions = '题目';
      strStudents = '学生';
    }
  }
}

class MultiMessageModifyEx2 {
//  _multiLang
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strTrue = '';
  var strFalse = '';
  var strHintInputAnswer = '';
  var strWarnTitle = '';
  var strWarnInputAnswer = '';
  var strWarnSelectAnswer = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '질문 수정';
      strHintTitle = '질문을 입력하세요';
      strTrue = '진실';
      strFalse = '거짓';
      strHintInputAnswer = '정답을 입력하세요';
      strWarnTitle = '질문을 입력하세요';
      strWarnInputAnswer = '정답을 입력하세요';
      strWarnSelectAnswer = '정답을 선택하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'Modify Question';
      strHintTitle = 'Please input the question';
      strTrue = 'TRUE';
      strFalse = 'FALSE';
      strHintInputAnswer = 'Please input the correct answer';
      strWarnTitle = 'Please input the question';
      strWarnInputAnswer = 'Please input the correct answer';
      strWarnSelectAnswer = 'Please select correct answer';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '修改';
      strHintTitle = '请输入问题';
      strTrue = '对';
      strFalse = '错';
      strHintInputAnswer = '请输入正确答案';
      strWarnTitle = '请输入问题';
      strWarnInputAnswer = '请输入正确答案';
      strWarnSelectAnswer = '请选择正确答案';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageModifyEx4 {
//  _multiLang
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strEx = '';
  var strHintInputEx = '';
  var strWarnTitle = '';
  var strWarnEx1 = '';
  var strWarnEx2 = '';
  var strWarnEx3 = '';
  var strWarnEx4 = '';
  var strWarnSelectAnswer = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '질문 수정';
      strHintTitle = '질문을 입력하세요';
      strEx = '예시';
      strHintInputEx = '예시를 입력하세요';
      strWarnTitle = '질문을 입력하세요';
      strWarnEx1 = '1번째 예시를 입력하세요';
      strWarnEx2 = '2번째 예시를 입력하세요';
      strWarnEx3 = '3번째 예시를 입력하세요';
      strWarnEx4 = '4번째 예시를 입력하세요';
      strWarnSelectAnswer = '정답을 선택하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'Modify Question';
      strHintTitle = 'Please input the question';
      strEx = 'ex';
      strHintInputEx = 'Please input the example';
      strWarnTitle = 'Please input the question';
      strWarnEx1 = 'Please input the 1st example';
      strWarnEx2 = 'Please input the 2nd example';
      strWarnEx3 = 'Please input the 3rd example';
      strWarnEx4 = 'Please input the 4th example';
      strWarnSelectAnswer = 'Please select correct answer';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '修改';
      strHintTitle = '请输入问题';
      strEx = '示例';
      strHintInputEx = '请输入示例';
      strWarnTitle = '请输入问题';
      strWarnEx1 = '请输入第一个示例';
      strWarnEx2 = '请输入第二个示例';
      strWarnEx3 = '请输入第三个示例';
      strWarnEx4 = '请输入第四个示例';
      strWarnSelectAnswer = '请选择正确答案';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageModifyMatch4 {
//  _multiLang
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strEx = '';
  var strWarnTitle = '';
  var strWarnEx1 = '';
  var strWarnEx2 = '';
  var strWarnEx3 = '';
  var strWarnEx4 = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '질문 수정';
      strHintTitle = '질문을 입력하세요';
      strEx = '예시';
      strWarnTitle = '질문을 입력하세요';
      strWarnEx1 = '1번째 예시를 입력하세요';
      strWarnEx2 = '2번째 예시를 입력하세요';
      strWarnEx3 = '3번째 예시를 입력하세요';
      strWarnEx4 = '4번째 예시를 입력하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'Modify Question';
      strHintTitle = 'Please input the question';
      strEx = 'ex';
      strWarnTitle = 'Please input the question';
      strWarnEx1 = 'Please input the 1st example';
      strWarnEx2 = 'Please input the 2nd example';
      strWarnEx3 = 'Please input the 3rd example';
      strWarnEx4 = 'Please input the 4th example';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '修改';
      strHintTitle = '请输入问题';
      strEx = '示例';
      strWarnTitle = '请输入问题';
      strWarnEx1 = '请输入第一个示例';
      strWarnEx2 = '请输入第二个示例';
      strWarnEx3 = '请输入第三个示例';
      strWarnEx4 = '请输入第四个示例';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}


class MultiMessageModifyMatchText {
//  _multiLang
  var strAppBarTitle = '';
  var strHintTitle = '';
  var strEx = '';
  var strWarnTitle = '';
  var strWarnEx1 = '';
  var strWarnEx2 = '';
  var strWarnEx3 = '';
  var strWarnEx4 = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '질문 수정';
      strHintTitle = '질문을 입력하세요';
      strEx = '예시';
      strWarnTitle = '질문을 입력하세요';
      strWarnEx1 = '1번째 예시를 입력하세요';
      strWarnEx2 = '2번째 예시를 입력하세요';
      strWarnEx3 = '3번째 예시를 입력하세요';
      strWarnEx4 = '4번째 예시를 입력하세요';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strAppBarTitle = 'Modify Question';
      strHintTitle = 'Please input the question';
      strEx = 'ex';
      strWarnTitle = 'Please input the question';
      strWarnEx1 = 'Please input the 1st example';
      strWarnEx2 = 'Please input the 2nd example';
      strWarnEx3 = 'Please input the 3rd example';
      strWarnEx4 = 'Please input the 4th example';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '修改';
      strHintTitle = '请输入问题';
      strEx = '示例';
      strWarnTitle = '请输入问题';
      strWarnEx1 = '请输入第一个示例';
      strWarnEx2 = '请输入第二个示例';
      strWarnEx3 = '请输入第三个示例';
      strWarnEx4 = '请输入第四个示例';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageResultEx2 {
//  _multiLang
  var strTrue = '';
  var strFalse = '';
  var strAnswer = '';
  var strWarnSave = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strTrue = '진실';
      strFalse = '거짓';
      strAnswer = '정답';
      strWarnSave = '이전 테스트 기록이 있어서 이번 테스트 기록은 저장되지 않습니다';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strTrue = 'TRUE';
      strFalse = 'FALSE';
      strAnswer = 'Correct';
      strWarnSave = 'You already did the test before, this test will not be saved';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strTrue = '对';
      strFalse = '错 ';
      strAnswer = '正确';
      strWarnSave = '你已经参与过测试, 本次测试结果将不会被保留.';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageResultEx4 {
//  _multiLang
  var strEx = '';
  var strWarnSave = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strEx = '예시';
      strWarnSave = '이전 테스트 기록이 있어서 이번 테스트 기록은 저장되지 않습니다';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strEx = 'ex';
      strWarnSave = 'You already did the test before, this test will not be saved';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strEx = '示例';
      strWarnSave = '你已经参与过测试, 本次测试结果将不会被保留.';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageResultMatch4 {
//  _multiLang
  var strEx = '';
  var strWarnSave = '';
  var strWarnMessage = '';
  var strOk = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strEx = '예시';
      strWarnSave = '이전 테스트 기록이 있어서 이번 테스트 기록은 저장되지 않습니다';
      strWarnMessage = '알림';
      strOk = '확인';
    }
    else if(type == 'English') {
      strEx = 'ex';
      strWarnSave = 'You already did the test before, this test will not be saved';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
    }
    else if(type == 'Chinese') {
      strEx = '示例';
      strWarnSave = '你已经参与过测试, 本次测试结果将不会被保留.';
      strWarnMessage = '提示';
      strOk = '确认';
    }
  }
}

class MultiMessageResultMatchText {
//  _multiLang
  var strEx = '';
  var strWarnSave = '';
  var strWarnMessage = '';
  var strOk = '';
  var strTeacher = '';
  var strStudent = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strEx = '예시';
      strWarnSave = '이전 테스트 기록이 있어서 이번 테스트 기록은 저장되지 않습니다';
      strWarnMessage = '알림';
      strOk = '확인';
      strTeacher = '선생님 정답';
      strStudent = '학생 정답';
    }
    else if(type == 'English') {
      strEx = 'ex';
      strWarnSave = 'You already did the test before, this test will not be saved';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
      strTeacher = 'Teacher answer';
      strStudent = 'Student answer';
    }
    else if(type == 'Chinese') {
      strEx = '示例';
      strWarnSave = '你已经参与过测试, 本次测试结果将不会被保留.';
      strWarnMessage = '提示';
      strOk = '确认';
      strTeacher = '正确答案';
      strStudent = '学生答案';
    }
  }
}

class MultiMessageStudy {
//  _multiLang
  var strAppBarTitle = '';
  var strNoData = '';
  var strNotice = '';
  var strTitle = '';
  var strQType = '';
  var strTestCode = '';
  var strQCnt = '';
  var strCreated = '';
  var strEx4 = '';
  var strTF = '';
  var strMatchPicture = '';//strMatch4/strMatchPicture
  var strMatchText = '';
  var strMultiEx4 = '';
  var strTestDate = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '차례';
      strNoData = '데이터 없음';
      strNotice = '선생님 전용 화면입니다';
      strTitle = '주제';
      strQType = '문제형식';
      strTestCode = '시험코드';
      strQCnt = '문항수';
      strCreated = '작성일';
      strEx4 = '선택형4';
      strTF = '참/거짓';
      strMatchPicture = '그림매칭';
      strMatchText = '문자매칭';
      strMultiEx4 = '다중선택4';
      strTestDate = '시험일자';
    }
    else if(type == 'English') {
      strAppBarTitle = 'List';
      strNoData = 'No data';
      strNotice = 'This is teacher only';
      strTitle = 'Title';
      strQType = 'Type';
      strTestCode = 'Test Code:  ';
      strQCnt = 'Questions';
      strCreated = 'Created';
      strEx4 = 'EX4';
      strTF = 'T/F';
      strMatchPicture = 'Picture Match';
      strMatchText = 'Text Match';
      strMultiEx4 = 'Multi EX4';
      strTestDate = 'Tested';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '目录';
      strNoData = '无数据';
      strNotice = '只限老师';
      strTitle = '主题';
      strQType = '类型';
      strTestCode = '题目代码';
      strQCnt = '问题数量';
      strCreated = '创建';
      strEx4 = '选择题';
      strTF = '对错题';
      strMatchPicture = '图片连线';
      strMatchText = '文字连线';
      strMultiEx4 = '多选题';
      strTestDate = '完成日期';
    }
  }
}

class MultiMessageTestMain {
//  _multiLang
  var strAppBarTitle = '';
  var strTeacherUid = '';
  var strTestCode = '';
  var strStudentName = '';
  var strWarnUid = '';
  var strWarnCode = '';
  var strWarnMessage = '';
  var strOk = '';
  var strNoData = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strAppBarTitle = '테스트 메인 화면';
      strTeacherUid = '선생님 코드';
      strTestCode = '시험코드';
      strStudentName = '학생이름';
      strWarnUid = '선생님코드를 입력하세요';
      strWarnCode = '시험코드를 입력하세요';
      strWarnMessage = '알림';
      strOk = '확인';
      strNoData = '데이터 없음';
    }
    else if(type == 'English') {
      strAppBarTitle = 'Test Main Page';
      strTeacherUid = 'Teacher UID';
      strTestCode = 'Test Code';
      strStudentName = 'Student Name';
      strWarnUid = 'Please input the Teacher UID Code';
      strWarnCode = 'Please input the Test Code';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
      strNoData = 'no data found';
    }
    else if(type == 'Chinese') {
      strAppBarTitle = '测试主页';
      strTeacherUid = '教师 UID';
      strTestCode = '测试编码';
    strStudentName = '参与测试人姓名';
    strWarnUid = '请输入老师UID编码';
    strWarnCode = '请输入问题码';
    strWarnMessage = '提示';
    strOk = '确认';
    strNoData = '找不到数据';
    }
  }
}

class MultiMessageTestEx2 {
//  _multiLang
  var strSubmit = '';
  var strNoData = '';
  var strNoTest = '';
  var strWarnQuestion = '';
  var strWarnMessage = '';
  var strOk = '';
  var strTrue = '';
  var strFalse = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strSubmit = '제출';
      strNoData = '데이터 없음';
      strNoTest = '테스트 없음';
      strWarnQuestion = '모든 질문을 확인해주세요';
      strWarnMessage = '알림';
      strOk = '확인';
      strTrue = '진실';
      strFalse = '거짓';
    }
    else if(type == 'English') {
      strSubmit = 'Submit';
      strNoData = 'No data';
      strNoTest = 'No test page';
      strWarnQuestion = 'Please click all questions';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
      strTrue = 'TRUE';
      strFalse = 'FALSE';
    }
    else if(type == 'Chinese') {
      strSubmit = '提交';
      strNoData = '无数据';
      strNoTest = '无法找到测试内容';
      strWarnQuestion = '请回答所有题目后提交';
      strWarnMessage = '提示';
      strOk = '确认';
      strTrue = '对';
      strFalse = '错';
    }
  }
}

class MultiMessageTestEx4 {
//  _multiLang
  var strSubmit = '';
  var strNoData = '';
  var strNoTest = '';
  var strWarnQuestion = '';
  var strWarnMessage = '';
  var strOk = '';
  var strEx = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strSubmit = '제출';
      strNoData = '데이터 없음';
      strNoTest = '테스트 없음';
      strWarnQuestion = '모든 질문을 확인해주세요';
      strWarnMessage = '알림';
      strOk = '확인';
      strEx = '예시';
    }
    else if(type == 'English') {
      strSubmit = 'Submit';
      strNoData = 'No data';
      strNoTest = 'No test page';
      strWarnQuestion = 'Please click all questions';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
      strEx = 'ex';
    }
    else if(type == 'Chinese') {
      strSubmit = '提交';
      strNoData = '无数据';
      strNoTest = '无法找到测试内容';
      strWarnQuestion = '请回答所有题目后提交';
      strWarnMessage = '提示';
      strOk = '确认';
      strEx = '示例';
    }
  }
}

class MultiMessageTestMatch4 {
//  _multiLang
  var strSubmit = '';
  var strNoData = '';
  var strNoTest = '';
  var strWarnQuestion = '';
  var strWarnSubQuestion = '';
  var strWarnMessage = '';
  var strOk = '';
  var strDragHere = '';
  var strEx = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strSubmit = '제출';
      strNoData = '데이터 없음';
      strNoTest = '테스트 없음';
      strWarnQuestion = '모든 질문을 확인해주세요';
      strWarnSubQuestion = '세부 질문을 확인해주세요';
      strWarnMessage = '알림';
      strOk = '확인';
      strDragHere = '여기로 이동해주세요';
      strEx = '예시';
    }
    else if(type == 'English') {
      strSubmit = 'Submit';
      strNoData = 'No data';
      strNoTest = 'No test page';
      strWarnQuestion = 'Please click all questions';
      strWarnSubQuestion = 'Please check all sub questions';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
      strDragHere = 'Drag here';
      strEx = 'ex';
    }
    else if(type == 'Chinese') {
      strSubmit = '提交';
      strNoData = '无数据';
      strNoTest = '无法找到测试内容';
      strWarnQuestion = '请回答所有题目后提交';
      strWarnSubQuestion = '请完成所有子题目';
      strWarnMessage = '提示';
      strOk = '确认';
      strDragHere = '拖拽至此';
      strEx = '示例';
    }
  }
}

class MultiMessageTestMatchText {
//  _multiLang
  var strSubmit = '';
  var strNoData = '';
  var strNoTest = '';
  var strWarnQuestion = '';
  var strWarnSubQuestion = '';
  var strWarnMessage = '';
  var strOk = '';
  var strDragHere = '';
  var strEx = '';

  void convertDescription(var type) {
//    print('(home page /MultiLangList)languageType: ' + type);
    if (type == 'Korean') {
      strSubmit = '제출';
      strNoData = '데이터 없음';
      strNoTest = '테스트 없음';
      strWarnQuestion = '모든 질문을 확인해주세요';
      strWarnSubQuestion = '세부 질문을 확인해주세요';
      strWarnMessage = '알림';
      strOk = '확인';
      strDragHere = '여기로 이동해주세요';
      strEx = '예시';
    }
    else if(type == 'English') {
      strSubmit = 'Submit';
      strNoData = 'No data';
      strNoTest = 'No test page';
      strWarnQuestion = 'Please click all questions';
      strWarnSubQuestion = 'Please check all sub questions';
      strWarnMessage = 'Notifications';
      strOk = 'OK';
      strDragHere = 'Drag here';
      strEx = 'ex';
    }
    else if(type == 'Chinese') {
      strSubmit = '提交';
      strNoData = '无数据';
      strNoTest = '无法找到测试内容';
      strWarnQuestion = '请回答所有题目后提交';
      strWarnSubQuestion = '请完成所有子题目';
      strWarnMessage = '提示';
      strOk = '确认';
      strDragHere = '拖拽至此';
      strEx = '示例';
    }
  }
}