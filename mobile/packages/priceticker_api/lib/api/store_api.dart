//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class StoreApi {
  StoreApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Store
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateStoreRequest] createStoreRequest (required):
  Future<Response> storesCreateWithHttpInfo(CreateStoreRequest createStoreRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/stores';

    // ignore: prefer_final_locals
    Object? postBody = createStoreRequest;

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

  /// Create Store
  ///
  /// Parameters:
  ///
  /// * [CreateStoreRequest] createStoreRequest (required):
  Future<StoresCreate201Response?> storesCreate(CreateStoreRequest createStoreRequest,) async {
    final response = await storesCreateWithHttpInfo(createStoreRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StoresCreate201Response',) as StoresCreate201Response;
    
    }
    return null;
  }

  /// Delete Store
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> storesDeleteWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/stores/{id}'
      .replaceAll('{id}', id);

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

  /// Delete Store
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<String?> storesDelete(String id,) async {
    final response = await storesDeleteWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }

  /// Show Store
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> storesDetailWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/stores/{id}'
      .replaceAll('{id}', id);

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

  /// Show Store
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<StoresDetail200Response?> storesDetail(String id,) async {
    final response = await storesDetailWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StoresDetail200Response',) as StoresDetail200Response;
    
    }
    return null;
  }

  /// List of Stores
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] filterLeftSquareBracketDomainRightSquareBracket:
  ///   Exact-match filter on a bare host such as \"www.Target.com.au\". Case and a leading \"www.\" are ignored. Unlike filter[domains], this does not partial match.
  Future<Response> storesPaginationWithHttpInfo({ String? filterLeftSquareBracketDomainRightSquareBracket, }) async {
    // ignore: prefer_const_declarations
    final path = r'/stores';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (filterLeftSquareBracketDomainRightSquareBracket != null) {
      queryParams.addAll(_queryParams('', 'filter[domain]', filterLeftSquareBracketDomainRightSquareBracket));
    }

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

  /// List of Stores
  ///
  /// Parameters:
  ///
  /// * [String] filterLeftSquareBracketDomainRightSquareBracket:
  ///   Exact-match filter on a bare host such as \"www.Target.com.au\". Case and a leading \"www.\" are ignored. Unlike filter[domains], this does not partial match.
  Future<StoresPagination200Response?> storesPagination({ String? filterLeftSquareBracketDomainRightSquareBracket, }) async {
    final response = await storesPaginationWithHttpInfo( filterLeftSquareBracketDomainRightSquareBracket: filterLeftSquareBracketDomainRightSquareBracket, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StoresPagination200Response',) as StoresPagination200Response;
    
    }
    return null;
  }

  /// Update Store
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateStoreRequest] updateStoreRequest:
  Future<Response> storesUpdateWithHttpInfo(String id, { UpdateStoreRequest? updateStoreRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/stores/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = updateStoreRequest;

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

  /// Update Store
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateStoreRequest] updateStoreRequest:
  Future<Object?> storesUpdate(String id, { UpdateStoreRequest? updateStoreRequest, }) async {
    final response = await storesUpdateWithHttpInfo(id,  updateStoreRequest: updateStoreRequest, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }
}
