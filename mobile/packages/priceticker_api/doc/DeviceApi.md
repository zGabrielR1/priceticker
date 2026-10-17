# priceticker_api.api.DeviceApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1DevicesDestroy**](DeviceApi.md#v1devicesdestroy) | **DELETE** /v1/devices/{device} | 
[**v1DevicesStore**](DeviceApi.md#v1devicesstore) | **POST** /v1/devices | 


# **v1DevicesDestroy**
> V1DevicesDestroy204Response v1DevicesDestroy(device)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DeviceApi();
final device = 56; // int | The device ID

try {
    final result = api_instance.v1DevicesDestroy(device);
    print(result);
} catch (e) {
    print('Exception when calling DeviceApi->v1DevicesDestroy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **device** | **int**| The device ID | 

### Return type

[**V1DevicesDestroy204Response**](V1DevicesDestroy204Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **v1DevicesStore**
> V1AlertsIndex200Response v1DevicesStore(v1DevicesStoreRequest)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = DeviceApi();
final v1DevicesStoreRequest = V1DevicesStoreRequest(); // V1DevicesStoreRequest | 

try {
    final result = api_instance.v1DevicesStore(v1DevicesStoreRequest);
    print(result);
} catch (e) {
    print('Exception when calling DeviceApi->v1DevicesStore: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **v1DevicesStoreRequest** | [**V1DevicesStoreRequest**](V1DevicesStoreRequest.md)|  | 

### Return type

[**V1AlertsIndex200Response**](V1AlertsIndex200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

