import 'dart:convert';
import 'dart:typed_data';
import '../schema/structs/index.dart';

import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Horan Group Code

class HoranGroup {
  static String getBaseUrl() => 'https://api.horan.et';
  static Map<String, String> headers = {};
  static SendConfirmationCodeCall sendConfirmationCodeCall =
      SendConfirmationCodeCall();
}

class SendConfirmationCodeCall {
  Future<ApiCallResponse> call({
    String? aastuEmail = '',
    String? clientId,
    String? activationCode = '',
  }) async {
    clientId ??= FFDevEnvironmentValues().ClientSecrate;
    final baseUrl = HoranGroup.getBaseUrl();

    final ffApiRequestBody = '''
{
  "app_name": "AASTU Students App",
  "user_email": "${aastuEmail}",
  "otp": "${activationCode}",
  "client_id": "${clientId}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'Send Confirmation Code',
      apiUrl: '${baseUrl}/send_otp',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Horan Group Code

/// Start OpenAI Group Code

class OpenAIGroup {
  static String getBaseUrl({
    String? apiKey,
  }) {
    apiKey ??= FFDevEnvironmentValues().APIKEY;
    return 'https://api.openai.com/v1/';
  }

  static Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer [API_KEY]',
  };
  static ChatGPTCall chatGPTCall = ChatGPTCall();
}

class ChatGPTCall {
  Future<ApiCallResponse> call({
    String? prompt = '',
    String? apiKey,
  }) async {
    apiKey ??= FFDevEnvironmentValues().APIKEY;
    final baseUrl = OpenAIGroup.getBaseUrl(
      apiKey: apiKey,
    );

    final ffApiRequestBody = '''
{
  "model": "gpt-3.5-turbo",
  "messages": [
    {
      "role": "user",
      "content": "${escapeStringForJson(prompt)}"
    }
  ],
  "temperature": 1.0
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ChatGPT',
      apiUrl: '${baseUrl}chat/completions',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${apiKey}',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End OpenAI Group Code

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}

String? escapeStringForJson(String? input) {
  if (input == null) {
    return null;
  }
  return input
      .replaceAll('\\', '\\\\')
      .replaceAll('"', '\\"')
      .replaceAll('\n', '\\n')
      .replaceAll('\t', '\\t');
}
