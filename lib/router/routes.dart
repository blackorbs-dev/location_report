abstract class Route{
  static const login = '/';
  static const dashboard = '/dashboard';
  static const reportList = '/reportList';
  static const addReport = '/addReport';
  static const editReport = '/editReport';
  static const reportDetail = '/reportDetail/:id';
  static const deleteReport = '/deleteReport';
  static const reportMap = '/reportMap';
  static const search = '/search';
  static const account = '/account';
  static const editProfile = '/editProfile';

  static String reportDetailPath(int id) => '/reportDetail/$id';
}