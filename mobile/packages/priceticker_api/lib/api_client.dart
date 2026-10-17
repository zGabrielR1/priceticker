//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: unawaited_return_in_try_block
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiClient {
  ApiClient({this.basePath = 'http://localhost/api', this.authentication,});

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType,
  ) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty ? '?${urlEncodedQueryParams.join('&')}' : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (
        body is MultipartFile && (contentType == null ||
        !contentType.toLowerCase().startsWith('multipart/form-data'))
      ) {
        final request = StreamedRequest(method, uri);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
          request.sink.add,
          onDone: request.sink.close,
          // ignore: avoid_types_on_closure_parameters
          onError: (Object error, StackTrace trace) => request.sink.close(),
          cancelOnError: true,
        );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = MultipartRequest(method, uri);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded'
        ? formParams
        : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      switch(method) {
        case 'POST': return await _client.post(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'PUT': return await _client.put(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'DELETE': return await _client.delete(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'PATCH': return await _client.patch(uri, headers: nullableHeaderParams, body: msgBody,);
        case 'HEAD': return await _client.head(uri, headers: nullableHeaderParams,);
        case 'GET': return await _client.get(uri, headers: nullableHeaderParams,);
      }
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }

    throw ApiException(
      HttpStatus.badRequest,
      'Invalid HTTP operation: $method $path',
    );
  }

  Future<dynamic> deserializeAsync(String value, String targetType, {bool growable = false,}) async =>
    // ignore: deprecated_member_use_from_same_package
    deserialize(value, targetType, growable: growable);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(String value, String targetType, {bool growable = false,}) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
      ? value
      : fromJson(json.decode(value), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

  /// Returns a native instance of an OpenAPI class matching the [specified type][targetType].
  static dynamic fromJson(dynamic value, String targetType, {bool growable = false,}) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'AuthLogin201Response':
          return AuthLogin201Response.fromJson(value);
        case 'AuthLogin401Response':
          return AuthLogin401Response.fromJson(value);
        case 'AuthLogout200Response':
          return AuthLogout200Response.fromJson(value);
        case 'ClientConfig200Response':
          return ClientConfig200Response.fromJson(value);
        case 'ClientConfig200ResponseData':
          return ClientConfig200ResponseData.fromJson(value);
        case 'ClientConfig200ResponseDataCapabilities':
          return ClientConfig200ResponseDataCapabilities.fromJson(value);
        case 'ClientConfig200ResponseDataLimits':
          return ClientConfig200ResponseDataLimits.fromJson(value);
        case 'CreateProductRequest':
          return CreateProductRequest.fromJson(value);
        case 'CreateProductSourceRequest':
          return CreateProductSourceRequest.fromJson(value);
        case 'CreateProductSourceRequestExtractionStrategy':
          return CreateProductSourceRequestExtractionStrategy.fromJson(value);
        case 'CreateProductSourceRequestExtractionStrategyListContainer':
          return CreateProductSourceRequestExtractionStrategyListContainer.fromJson(value);
        case 'CreateStoreRequest':
          return CreateStoreRequest.fromJson(value);
        case 'CreateStoreRequestDomainsInner':
          return CreateStoreRequestDomainsInner.fromJson(value);
        case 'CreateStoreRequestScrapeStrategy':
          return CreateStoreRequestScrapeStrategy.fromJson(value);
        case 'CreateStoreRequestScrapeStrategyImage':
          return CreateStoreRequestScrapeStrategyImage.fromJson(value);
        case 'CreateStoreRequestSettings':
          return CreateStoreRequestSettings.fromJson(value);
        case 'CreateStoreRequestSettingsLocaleSettings':
          return CreateStoreRequestSettingsLocaleSettings.fromJson(value);
        case 'CreateTagRequest':
          return CreateTagRequest.fromJson(value);
        case 'LoginRequest':
          return LoginRequest.fromJson(value);
        case 'MetaExtraction200Response':
          return MetaExtraction200Response.fromJson(value);
        case 'MetaExtractionRequest':
          return MetaExtractionRequest.fromJson(value);
        case 'MetaExtractionRequestStore':
          return MetaExtractionRequestStore.fromJson(value);
        case 'MetaExtractionRequestStoreDomainsInner':
          return MetaExtractionRequestStoreDomainsInner.fromJson(value);
        case 'MetaExtractionRequestStoreScrapeStrategy':
          return MetaExtractionRequestStoreScrapeStrategy.fromJson(value);
        case 'MetaExtractionRequestStoreScrapeStrategyTitle':
          return MetaExtractionRequestStoreScrapeStrategyTitle.fromJson(value);
        case 'MetaExtractionRequestStoreSettings':
          return MetaExtractionRequestStoreSettings.fromJson(value);
        case 'MetaExtractionRequestStoreSettingsLocaleSettings':
          return MetaExtractionRequestStoreSettingsLocaleSettings.fromJson(value);
        case 'MetaExtractionResource':
          return MetaExtractionResource.fromJson(value);
        case 'MetaExtractionResourceCurrency':
          return MetaExtractionResourceCurrency.fromJson(value);
        case 'ProductSourceResultsTransformer':
          return ProductSourceResultsTransformer.fromJson(value);
        case 'ProductSourceStatus':
          return ProductSourceStatusTypeTransformer().decode(value);
        case 'ProductSourceTransformer':
          return ProductSourceTransformer.fromJson(value);
        case 'ProductSourceType':
          return ProductSourceTypeTypeTransformer().decode(value);
        case 'ProductSourcesCreate201Response':
          return ProductSourcesCreate201Response.fromJson(value);
        case 'ProductSourcesDetail200Response':
          return ProductSourcesDetail200Response.fromJson(value);
        case 'ProductSourcesDetail200ResponseAnyOf':
          return ProductSourcesDetail200ResponseAnyOf.fromJson(value);
        case 'ProductSourcesPagination200Response':
          return ProductSourcesPagination200Response.fromJson(value);
        case 'ProductSourcesSearch200Response':
          return ProductSourcesSearch200Response.fromJson(value);
        case 'ProductSourcesSearchAll200Response':
          return ProductSourcesSearchAll200Response.fromJson(value);
        case 'ProductTransformer':
          return ProductTransformer.fromJson(value);
        case 'ProductsCreate201Response':
          return ProductsCreate201Response.fromJson(value);
        case 'ProductsDetail200Response':
          return ProductsDetail200Response.fromJson(value);
        case 'ProductsDetail200ResponseAnyOf':
          return ProductsDetail200ResponseAnyOf.fromJson(value);
        case 'ProductsPagination200Response':
          return ProductsPagination200Response.fromJson(value);
        case 'Statuses':
          return StatusesTypeTransformer().decode(value);
        case 'StoreResource':
          return StoreResource.fromJson(value);
        case 'StoreResourceCurrency':
          return StoreResourceCurrency.fromJson(value);
        case 'StoreTransformer':
          return StoreTransformer.fromJson(value);
        case 'StoreTransformerCurrency':
          return StoreTransformerCurrency.fromJson(value);
        case 'StoresCreate201Response':
          return StoresCreate201Response.fromJson(value);
        case 'StoresDetail200Response':
          return StoresDetail200Response.fromJson(value);
        case 'StoresDetail200ResponseAnyOf':
          return StoresDetail200ResponseAnyOf.fromJson(value);
        case 'StoresPagination200Response':
          return StoresPagination200Response.fromJson(value);
        case 'SyncProductTagsRequest':
          return SyncProductTagsRequest.fromJson(value);
        case 'TagTransformer':
          return TagTransformer.fromJson(value);
        case 'TagsCreate201Response':
          return TagsCreate201Response.fromJson(value);
        case 'TagsDetail200Response':
          return TagsDetail200Response.fromJson(value);
        case 'TagsDetail200ResponseAnyOf':
          return TagsDetail200ResponseAnyOf.fromJson(value);
        case 'TagsPagination200Response':
          return TagsPagination200Response.fromJson(value);
        case 'UpdateProductRequest':
          return UpdateProductRequest.fromJson(value);
        case 'UpdateProductSourceRequest':
          return UpdateProductSourceRequest.fromJson(value);
        case 'UpdateProductSourceRequestExtractionStrategy':
          return UpdateProductSourceRequestExtractionStrategy.fromJson(value);
        case 'UpdateProductSourceRequestExtractionStrategyListContainer':
          return UpdateProductSourceRequestExtractionStrategyListContainer.fromJson(value);
        case 'UpdateStoreRequest':
          return UpdateStoreRequest.fromJson(value);
        case 'UpdateStoreRequestScrapeStrategy':
          return UpdateStoreRequestScrapeStrategy.fromJson(value);
        case 'UpdateStoreRequestScrapeStrategyImage':
          return UpdateStoreRequestScrapeStrategyImage.fromJson(value);
        case 'UpdateStoreRequestScrapeStrategyPrice':
          return UpdateStoreRequestScrapeStrategyPrice.fromJson(value);
        case 'UpdateStoreRequestSettings':
          return UpdateStoreRequestSettings.fromJson(value);
        case 'UpdateTagRequest':
          return UpdateTagRequest.fromJson(value);
        case 'UrlResource':
          return UrlResource.fromJson(value);
        case 'UserResource':
          return UserResource.fromJson(value);
        case 'V1AlertsIndex200Response':
          return V1AlertsIndex200Response.fromJson(value);
        case 'V1AlertsRead200Response':
          return V1AlertsRead200Response.fromJson(value);
        case 'V1AuthRevoke200Response':
          return V1AuthRevoke200Response.fromJson(value);
        case 'V1AuthToken200Response':
          return V1AuthToken200Response.fromJson(value);
        case 'V1AuthTokenRequest':
          return V1AuthTokenRequest.fromJson(value);
        case 'V1DevicesDestroy204Response':
          return V1DevicesDestroy204Response.fromJson(value);
        case 'V1DevicesDestroy403Response':
          return V1DevicesDestroy403Response.fromJson(value);
        case 'V1DevicesStoreRequest':
          return V1DevicesStoreRequest.fromJson(value);
        case 'Watch':
          return Watch.fromJson(value);
        case 'WatchType':
          return WatchTypeTypeTransformer().decode(value);
        case 'WatchesShow200Response':
          return WatchesShow200Response.fromJson(value);
        case 'WatchesStoreRequest':
          return WatchesStoreRequest.fromJson(value);
        case 'WatchesUpdateRequest':
          return WatchesUpdateRequest.fromJson(value);
        default:
          dynamic match;
          if (value is List && (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toList(growable: growable);
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toSet();
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,)),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(HttpStatus.internalServerError, 'Exception during deserialization.', error, trace,);
    }
    throw ApiException(HttpStatus.internalServerError, 'Could not find a suitable class for deserialization',);
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> decodeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : json.decode(message.json);
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : ApiClient.fromJson(
        json.decode(message.json),
        targetType,
        growable: message.growable,
      );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);
