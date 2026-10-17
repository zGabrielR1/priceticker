# priceticker_api.api.WatchApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**watchesDestroy**](WatchApi.md#watchesdestroy) | **DELETE** /v1/watches/{watch} | 
[**watchesIndex**](WatchApi.md#watchesindex) | **GET** /v1/watches | 
[**watchesShow**](WatchApi.md#watchesshow) | **GET** /v1/watches/{watch} | 
[**watchesStore**](WatchApi.md#watchesstore) | **POST** /v1/watches | 
[**watchesUpdate**](WatchApi.md#watchesupdate) | **PUT** /v1/watches/{watch} | 


# **watchesDestroy**
> V1DevicesDestroy204Response watchesDestroy(watch)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = WatchApi();
final watch = 56; // int | The watch ID

try {
    final result = api_instance.watchesDestroy(watch);
    print(result);
} catch (e) {
    print('Exception when calling WatchApi->watchesDestroy: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **watch** | **int**| The watch ID | 

### Return type

[**V1DevicesDestroy204Response**](V1DevicesDestroy204Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **watchesIndex**
> V1AlertsIndex200Response watchesIndex()



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = WatchApi();

try {
    final result = api_instance.watchesIndex();
    print(result);
} catch (e) {
    print('Exception when calling WatchApi->watchesIndex: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**V1AlertsIndex200Response**](V1AlertsIndex200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **watchesShow**
> WatchesShow200Response watchesShow(watch)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = WatchApi();
final watch = 56; // int | The watch ID

try {
    final result = api_instance.watchesShow(watch);
    print(result);
} catch (e) {
    print('Exception when calling WatchApi->watchesShow: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **watch** | **int**| The watch ID | 

### Return type

[**WatchesShow200Response**](WatchesShow200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **watchesStore**
> V1AlertsIndex200Response watchesStore(watchesStoreRequest)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = WatchApi();
final watchesStoreRequest = WatchesStoreRequest(); // WatchesStoreRequest | 

try {
    final result = api_instance.watchesStore(watchesStoreRequest);
    print(result);
} catch (e) {
    print('Exception when calling WatchApi->watchesStore: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **watchesStoreRequest** | [**WatchesStoreRequest**](WatchesStoreRequest.md)|  | 

### Return type

[**V1AlertsIndex200Response**](V1AlertsIndex200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **watchesUpdate**
> V1AlertsIndex200Response watchesUpdate(watch, watchesUpdateRequest)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = WatchApi();
final watch = 56; // int | The watch ID
final watchesUpdateRequest = WatchesUpdateRequest(); // WatchesUpdateRequest | 

try {
    final result = api_instance.watchesUpdate(watch, watchesUpdateRequest);
    print(result);
} catch (e) {
    print('Exception when calling WatchApi->watchesUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **watch** | **int**| The watch ID | 
 **watchesUpdateRequest** | [**WatchesUpdateRequest**](WatchesUpdateRequest.md)|  | [optional] 

### Return type

[**V1AlertsIndex200Response**](V1AlertsIndex200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

