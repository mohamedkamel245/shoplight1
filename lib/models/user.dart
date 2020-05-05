class User {
  int customer_id;
  String customer_email;
  String customer_pass;
  String customer_name;

  toJson(){
    return {
      'customer_id' : customer_id.toString(),
      'customer_email' : customer_email,
      'customer_pass' : customer_pass,
      'customer_name' : customer_name,
    };
  }
}