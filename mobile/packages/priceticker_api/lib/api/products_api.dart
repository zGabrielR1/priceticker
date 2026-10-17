//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProductsApi {
  ProductsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Product
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CreateProductRequest] createProductRequest (required):
  Future<Response> productsCreateWithHttpInfo(CreateProductRequest createProductRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/products';

    // ignore: prefer_final_locals
    Object? postBody = createProductRequest;

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

  /// Create Product
  ///
  /// Parameters:
  ///
  /// * [CreateProductRequest] createProductRequest (required):
  Future<ProductsCreate201Response?> productsCreate(CreateProductRequest createProductRequest,) async {
    final response = await productsCreateWithHttpInfo(createProductRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductsCreate201Response',) as ProductsCreate201Response;
    
    }
    return null;
  }

  /// Delete Product
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> productsDeleteWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/products/{id}'
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

  /// Delete Product
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<String?> productsDelete(String id,) async {
    final response = await productsDeleteWithHttpInfo(id,);
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

  /// Remove Product Tag
  ///
  /// Removes one tag from the product. The tag record itself is not deleted.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] tagId (required):
  Future<Response> productsDetachTagWithHttpInfo(String id, String tagId,) async {
    // ignore: prefer_const_declarations
    final path = r'/products/{id}/tags/{tagId}'
      .replaceAll('{id}', id)
      .replaceAll('{tagId}', tagId);

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

  /// Remove Product Tag
  ///
  /// Removes one tag from the product. The tag record itself is not deleted.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] tagId (required):
  Future<String?> productsDetachTag(String id, String tagId,) async {
    final response = await productsDetachTagWithHttpInfo(id, tagId,);
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

  /// Show Product
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] currentUrl:
  ///   Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean, true for the listing matching this page.
  Future<Response> productsDetailWithHttpInfo(String id, { String? currentUrl, }) async {
    // ignore: prefer_const_declarations
    final path = r'/products/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (currentUrl != null) {
      queryParams.addAll(_queryParams('', 'current_url', currentUrl));
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

  /// Show Product
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [String] currentUrl:
  ///   Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean, true for the listing matching this page.
  Future<ProductsDetail200Response?> productsDetail(String id, { String? currentUrl, }) async {
    final response = await productsDetailWithHttpInfo(id,  currentUrl: currentUrl, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductsDetail200Response',) as ProductsDetail200Response;
    
    }
    return null;
  }

  /// List of Products
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] filterLeftSquareBracketUrlRightSquareBracket:
  ///   Return products tracking this page URL. Matching is normalised: scheme, port, \"www.\", trailing slashes, casing and tracking parameters are ignored.
  ///
  /// * [String] currentUrl:
  ///   Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean.
  Future<Response> productsPaginationWithHttpInfo({ String? filterLeftSquareBracketUrlRightSquareBracket, String? currentUrl, }) async {
    // ignore: prefer_const_declarations
    final path = r'/products';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (filterLeftSquareBracketUrlRightSquareBracket != null) {
      queryParams.addAll(_queryParams('', 'filter[url]', filterLeftSquareBracketUrlRightSquareBracket));
    }
    if (currentUrl != null) {
      queryParams.addAll(_queryParams('', 'current_url', currentUrl));
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

  /// List of Products
  ///
  /// Parameters:
  ///
  /// * [String] filterLeftSquareBracketUrlRightSquareBracket:
  ///   Return products tracking this page URL. Matching is normalised: scheme, port, \"www.\", trailing slashes, casing and tracking parameters are ignored.
  ///
  /// * [String] currentUrl:
  ///   Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean.
  Future<ProductsPagination200Response?> productsPagination({ String? filterLeftSquareBracketUrlRightSquareBracket, String? currentUrl, }) async {
    final response = await productsPaginationWithHttpInfo( filterLeftSquareBracketUrlRightSquareBracket: filterLeftSquareBracketUrlRightSquareBracket, currentUrl: currentUrl, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductsPagination200Response',) as ProductsPagination200Response;
    
    }
    return null;
  }

  /// Set Product Tags
  ///
  /// Replaces the product's tags with the given tag ids. Send an empty list to remove all tags.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [SyncProductTagsRequest] syncProductTagsRequest (required):
  Future<Response> productsSyncTagsWithHttpInfo(String id, SyncProductTagsRequest syncProductTagsRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/products/{id}/tags'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = syncProductTagsRequest;

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

  /// Set Product Tags
  ///
  /// Replaces the product's tags with the given tag ids. Send an empty list to remove all tags.
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [SyncProductTagsRequest] syncProductTagsRequest (required):
  Future<Object?> productsSyncTags(String id, SyncProductTagsRequest syncProductTagsRequest,) async {
    final response = await productsSyncTagsWithHttpInfo(id, syncProductTagsRequest,);
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

  /// Update Product
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateProductRequest] updateProductRequest (required):
  Future<Response> productsUpdateWithHttpInfo(String id, UpdateProductRequest updateProductRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/products/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = updateProductRequest;

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

  /// Update Product
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [UpdateProductRequest] updateProductRequest (required):
  Future<Object?> productsUpdate(String id, UpdateProductRequest updateProductRequest,) async {
    final response = await productsUpdateWithHttpInfo(id, updateProductRequest,);
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
