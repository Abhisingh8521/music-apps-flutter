void main() {
  var mobile1 = Mobile();
  var mobile2 = Mobile();
  var mobile3 = Mobile();
mobile1.setData(n:"realme", p:1234, b:"4000mah", c:"black");
mobile1.showData();
mobile2.setData(n: 'oppo',b: "3000mah",c: "red",p: 123234);
mobile2.showData();
mobile3.setData(n: 'vivo',b: "6000mah",c: "blue",p: 3234);
mobile3.showData();
}
class Mobile{
  String? name;
  int? price;
  String? battery;
  String? color;
  void showData(){
    print(name);
    print(price);
    print(battery);
    print(color);
  }
  void setData({required String n, required int p, required String b, required String c}){
    name = n;
    price = p;
    battery = b;
    color = c;
  }
}


// user,seller , customer
// p- name , age , email , address , gender ,
 //   m- setData(),getData();
// constructor