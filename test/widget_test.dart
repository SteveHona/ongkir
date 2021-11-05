import 'package:http/http.dart' as http;

void main() async {
  Uri url = Uri.parse("https://api.rajaongkir.com/starter/cost");
  final response = await http.post(url, headers: {
    "content-type": "application/x-www-form-urlencoded",
    "key": "06ce6a002911ef698fca248a38f41dc3"
  });
  print(response.body);
}
