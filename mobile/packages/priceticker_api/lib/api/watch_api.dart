//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class WatchApi {
  WatchApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /v1/watches/{watch}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] watch (required):
  ///   The watch ID
  Future<Response> watchesDestroyWithHttpInfo(int watch,) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/watches/{watch}'
      .replaceAll('{watch}', watch.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] watch (required):
  ///   The watch ID
  Future<V1DevicesDestroy204Response?> watchesDestroy(int watch,) async {
    final response = await watchesDestroyWithHttpInfo(watch,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'V1DevicesDestroy204Response',) as V1DevicesDestroy204Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /v1/watches' operation and returns the [Response].
  Future<Response> watchesIndexWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/v1/watches';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  Future<V1AlertsIndex200Response?> watchesIndex() async {
    final response = await watchesIndexWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'V1AlertsIndex200Response',) as V1AlertsIndex200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'GET /v1/watches/{watch}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] watch (required):
  ///   The watch ID
  Future<Response> watchesShowWithHttpInfo(int watch,) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/watches/{watch}'
      .replaceAll('{watch}', watch.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] watch (required):
  ///   The watch ID
  Future<WatchesShow200Response?> watchesShow(int watch,) async {
    final response = await watchesShowWithHttpInfo(watch,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'WatchesShow200Response',) as WatchesShow200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'POST /v1/watches' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [WatchesStoreRequest] watchesStoreRequest (required):
  Future<Response> watchesStoreWithHttpInfo(WatchesStoreRequest watchesStoreRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/watches';

    // ignore: prefer_final_locals
    Object? postBody = watchesStoreRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [WatchesStoreRequest] watchesStoreRequest (required):
  Future<V1AlertsIndex200Response?> watchesStore(WatchesStoreRequest watchesStoreRequest,) async {
    final response = await watchesStoreWithHttpInfo(watchesStoreRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'V1AlertsIndex200Response',) as V1AlertsIndex200Response;
    
    }
    return null;
  }

  /// Performs an HTTP 'PUT /v1/watches/{watch}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] watch (required):
  ///   The watch ID
  ///
  /// * [WatchesUpdateRequest] watchesUpdateRequest:
  Future<Response> watchesUpdateWithHttpInfo(int watch, { WatchesUpdateRequest? watchesUpdateRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/watches/{watch}'
      .replaceAll('{watch}', watch.toString());

    // ignore: prefer_final_locals
    Object? postBody = watchesUpdateRequest;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Parameters:
  ///
  /// * [int] watch (required):
  ///   The watch ID
  ///
  /// * [WatchesUpdateRequest] watchesUpdateRequest:
  Future<V1AlertsIndex200Response?> watchesUpdate(int watch, { WatchesUpdateRequest? watchesUpdateRequest, }) async {
    final response = await watchesUpdateWithHttpInfo(watch,  watchesUpdateRequest: watchesUpdateRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'V1AlertsIndex200Response',) as V1AlertsIndex200Response;
    
    }
    return null;
  }
}
