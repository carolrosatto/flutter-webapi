// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Future<List<Transaction>> findAll() async {
  var baseUrl = Uri.parse('http://192.168.0.22:8080/transactions');
  final Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );
  final Response response = await client.get(baseUrl);
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];

  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Request:');
    print('Method: ${data.method}');
    print('URL: ${data.baseUrl}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Response:');
    print('Status code: ${data.statusCode}');
    print('Headers: ${data.headers}');
    print('Body: ${data.body}');

    return data;
  }
}
