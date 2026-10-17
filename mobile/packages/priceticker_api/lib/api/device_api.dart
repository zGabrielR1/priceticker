//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DeviceApi {
  DeviceApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Performs an HTTP 'DELETE /v1/devices/{device}' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [int] device (required):
  ///   The device ID
  Future<Response> v1DevicesDestroyWithHttpInfo(int device,) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/devices/{device}'
      .replaceAll('{device}', device.toString());

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
  /// * [int] device (required):
  ///   The device ID
  Future<V1DevicesDestroy204Response?> v1DevicesDestroy(int device,) async {
    final response = await v1DevicesDestroyWithHttpInfo(device,);
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

  /// Performs an HTTP 'POST /v1/devices' operation and returns the [Response].
  /// Parameters:
  ///
  /// * [V1DevicesStoreRequest] v1DevicesStoreRequest (required):
  Future<Response> v1DevicesStoreWithHttpInfo(V1DevicesStoreRequest v1DevicesStoreRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/devices';

    // ignore: prefer_final_locals
    Object? postBody = v1DevicesStoreRequest;

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
  /// * [V1DevicesStoreRequest] v1DevicesStoreRequest (required):
  Future<V1AlertsIndex200Response?> v1DevicesStore(V1DevicesStoreRequest v1DevicesStoreRequest,) async {
    final response = await v1DevicesStoreWithHttpInfo(v1DevicesStoreRequest,);
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
