import 'dart:convert';
import 'dart:io';

import 'package:betta_1_http/post.dart';

class ApiClient {
  // создаем экземпляр http клиента
  final client = HttpClient();

  // делаем метод, который будет обращаться к серверу
  Future<List<Post>> getPost() async {
    // распарсим ссылку через строку
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    // асинхронная функция - производим запрос к клиенту с помощью ссылки
    final request = await client.getUrl(url);
    // асинхронная функция - выполнить реквест - close отправляет на сервер запрос
    // респорс - это по факту стрим списков чисел (стрим массивов байт)
    // там закодирован json
    final response = await request.close();
    // асинхронная функция - трансформируем респонс из чисел в строки и превращаем в список
    final jsonStrings = await response.transform(utf8.decoder).toList();
    // так как из сервера все приходит урывками, здесь мы склеиваем в один массив
    final jsonString = jsonStrings.join();
    // декодируем из строки json в List динамиков
    final json = jsonDecode(jsonString) as List<dynamic>;
    // мапим json, каждый элемент из листа динамиков, эти же динамики превратили
    // в объекты Post
    final posts =
        json.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
    // на выходе у нас List<Post>
    return posts;
  }
}
