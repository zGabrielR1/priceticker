# priceticker_api.api.AlertApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1AlertsIndex**](AlertApi.md#v1alertsindex) | **GET** /v1/alerts | 
[**v1AlertsRead**](AlertApi.md#v1alertsread) | **POST** /v1/alerts/{id}/read | 


# **v1AlertsIndex**
> V1AlertsIndex200Response v1AlertsIndex()



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AlertApi();

try {
    final result = api_instance.v1AlertsIndex();
    print(result);
} catch (e) {
    print('Exception when calling AlertApi->v1AlertsIndex: $e\n');
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

# **v1AlertsRead**
> V1AlertsRead200Response v1AlertsRead(id)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = AlertApi();
final id = id_example; // String | 

try {
    final result = api_instance.v1AlertsRead(id);
    print(result);
} catch (e) {
    print('Exception when calling AlertApi->v1AlertsRead: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**V1AlertsRead200Response**](V1AlertsRead200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

