class ApiEndpoints {
  static const forgotPassword = 'api/v1/auth/forgotPassword';
  static const changePassword = 'api/v1/auth/changePassword';
  static const verifyResetCode = 'api/v1/auth/verifyResetCode';
  static const resetPassword = 'api/v1/auth/resetPassword';
  static const getUserInfo = 'api/v1/auth/profileData';
  static const editProfile = 'api/v1/auth/editProfile';
  static const deleteAccount = 'api/v1/auth/deleteMe';
  static const logout = 'api/v1/auth/logout';
  static const signup = 'api/v1/auth/signup';
  static const signin = 'api/v1/auth/signin';
  static const addExam = 'api/v1/exams';

  static const getAllExams       = 'api/v1/exams';
  static const getExamsBySubject = 'api/v1/exams';

  static const getSubjects = 'api/v1/subjects';

  static const publicEndpoints = [
    signin,
    signup,
    forgotPassword,
    verifyResetCode,
    resetPassword,
  ];
}
