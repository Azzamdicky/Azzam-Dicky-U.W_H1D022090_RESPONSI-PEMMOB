class ApiUrl {
  static const String baseUrl ='http://103.196.155.42/api'; //sesuaikan dengan ip laptop / localhost teman teman / url server Codeigniter

  static const String registrasi = baseUrl + '/registrasi';
  static const String login = baseUrl + '/login';
  static const String listUang = baseUrl + '/keuangan/mata_uang';
  static const String createUang = baseUrl + '/keuangan/mata_uang';

  static String updateUang(int id) {
    return '$baseUrl/keuangan/mata_uang/$id/update'; 
  }

  static String showUang(int id) {
    return '$baseUrl/keuangan/mata_uang/$id'; 
  }

  static String deleteUang(int id) {
    return '$baseUrl/keuangan/mata_uang/$id/delete'; 
  }
}
