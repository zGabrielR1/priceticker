# priceticker_api.api.ClientConfigApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**clientConfig**](ClientConfigApi.md#clientconfig) | **GET** /client-config | Client configuration


# **clientConfig**
> ClientConfig200Response clientConfig()

Client configuration

Returns the capabilities this instance supports and its application version. Cached for a day; send If-None-Match to get a 304.  The payload is a hand-picked, literal allowlist of fields rather than a serialised settings model or config dump. Endpoints like this accrete fields over time, and an automatic serialisation is a classic route for leaking scraper keys or webhook URLs. Add new fields here explicitly, never by looping over config or model attributes.

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ClientConfigApi();

try {
    final result = api_instance.clientConfig();
    print(result);
} catch (e) {
    print('Exception when calling ClientConfigApi->clientConfig: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ClientConfig200Response**](ClientConfig200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

