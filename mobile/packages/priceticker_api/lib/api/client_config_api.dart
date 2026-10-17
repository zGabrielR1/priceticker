//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ClientConfigApi {
  ClientConfigApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Client configuration
  ///
  /// Returns the capabilities this instance supports and its application version. Cached for a day; send If-None-Match to get a 304.  The payload is a hand-picked, literal allowlist of fields rather than a serialised settings model or config dump. Endpoints like this accrete fields over time, and an automatic serialisation is a classic route for leaking scraper keys or webhook URLs. Add new fields here explicitly, never by looping over config or model attributes.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> clientConfigWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/client-config';

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

  /// Client configuration
  ///
  /// Returns the capabilities this instance supports and its application version. Cached for a day; send If-None-Match to get a 304.  The payload is a hand-picked, literal allowlist of fields rather than a serialised settings model or config dump. Endpoints like this accrete fields over time, and an automatic serialisation is a classic route for leaking scraper keys or webhook URLs. Add new fields here explicitly, never by looping over config or model attributes.
  Future<ClientConfig200Response?> clientConfig() async {
    final response = await clientConfigWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClientConfig200Response',) as ClientConfig200Response;
    
    }
    return null;
  }
}
