//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProductSourceApi {
  ProductSourceApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Product Source
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateProductSourceRequest] createProductSourceRequest (required):
  Future<Response> productSourcesCreateWithHttpInfo(CreateProductSourceRequest createProductSourceRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources';

    // ignore: prefer_final_locals
    Object? postBody = createProductSourceRequest;

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

  /// Create Product Source
  ///
  /// Parameters:
  ///
  /// * [CreateProductSourceRequest] createProductSourceRequest (required):
  Future<ProductSourcesCreate201Response?> productSourcesCreate(CreateProductSourceRequest createProductSourceRequest,) async {
    final response = await productSourcesCreateWithHttpInfo(createProductSourceRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductSourcesCreate201Response',) as ProductSourcesCreate201Response;
    
    }
    return null;
  }

  /// Delete Product Source
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> productSourcesDeleteWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources/{id}'
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

  /// Delete Product Source
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<String?> productSourcesDelete(String id,) async {
    final response = await productSourcesDeleteWithHttpInfo(id,);
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

  /// Show Product Source
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> productSourcesDetailWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources/{id}'
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

  /// Show Product Source
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ProductSourcesDetail200Response?> productSourcesDetail(String id,) async {
    final response = await productSourcesDetailWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductSourcesDetail200Response',) as ProductSourcesDetail200Response;
    
    }
    return null;
  }

  /// List of Product Sources
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> productSourcesPaginationWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources';

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

  /// List of Product Sources
  Future<ProductSourcesPagination200Response?> productSourcesPagination() async {
    final response = await productSourcesPaginationWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductSourcesPagination200Response',) as ProductSourcesPagination200Response;
    
    }
    return null;
  }

  /// Search via Product Source
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] query (required):
  Future<Response> productSourcesSearchWithHttpInfo(String id, String query,) async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources/{id}/search/{query}'
      .replaceAll('{id}', id)
      .replaceAll('{query}', query);

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

  /// Search via Product Source
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] query (required):
  Future<ProductSourcesSearch200Response?> productSourcesSearch(String id, String query,) async {
    final response = await productSourcesSearchWithHttpInfo(id, query,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductSourcesSearch200Response',) as ProductSourcesSearch200Response;
    
    }
    return null;
  }

  /// Search all Product Sources
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] query (required):
  Future<Response> productSourcesSearchAllWithHttpInfo(String query,) async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources/search/{query}'
      .replaceAll('{query}', query);

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

  /// Search all Product Sources
  ///
  /// Parameters:
  ///
  /// * [String] query (required):
  Future<ProductSourcesSearchAll200Response?> productSourcesSearchAll(String query,) async {
    final response = await productSourcesSearchAllWithHttpInfo(query,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductSourcesSearchAll200Response',) as ProductSourcesSearchAll200Response;
    
    }
    return null;
  }

  /// Update Product Source
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateProductSourceRequest] updateProductSourceRequest:
  Future<Response> productSourcesUpdateWithHttpInfo(String id, { UpdateProductSourceRequest? updateProductSourceRequest, }) async {
    // ignore: prefer_const_declarations
    final path = r'/product-sources/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = updateProductSourceRequest;

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

  /// Update Product Source
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateProductSourceRequest] updateProductSourceRequest:
  Future<Object?> productSourcesUpdate(String id, { UpdateProductSourceRequest? updateProductSourceRequest, }) async {
    final response = await productSourcesUpdateWithHttpInfo(id,  updateProductSourceRequest: updateProductSourceRequest, );
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
