# priceticker_api.api.StoreApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**storesCreate**](StoreApi.md#storescreate) | **POST** /stores | Create Store
[**storesDelete**](StoreApi.md#storesdelete) | **DELETE** /stores/{id} | Delete Store
[**storesDetail**](StoreApi.md#storesdetail) | **GET** /stores/{id} | Show Store
[**storesPagination**](StoreApi.md#storespagination) | **GET** /stores | List of Stores
[**storesUpdate**](StoreApi.md#storesupdate) | **PUT** /stores/{id} | Update Store


# **storesCreate**
> StoresCreate201Response storesCreate(createStoreRequest)

Create Store

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StoreApi();
final createStoreRequest = CreateStoreRequest(); // CreateStoreRequest | 

try {
    final result = api_instance.storesCreate(createStoreRequest);
    print(result);
} catch (e) {
    print('Exception when calling StoreApi->storesCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createStoreRequest** | [**CreateStoreRequest**](CreateStoreRequest.md)|  | 

### Return type

[**StoresCreate201Response**](StoresCreate201Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storesDelete**
> String storesDelete(id)

Delete Store

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StoreApi();
final id = id_example; // String | 

try {
    final result = api_instance.storesDelete(id);
    print(result);
} catch (e) {
    print('Exception when calling StoreApi->storesDelete: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

**String**

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storesDetail**
> StoresDetail200Response storesDetail(id)

Show Store

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StoreApi();
final id = id_example; // String | 

try {
    final result = api_instance.storesDetail(id);
    print(result);
} catch (e) {
    print('Exception when calling StoreApi->storesDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**StoresDetail200Response**](StoresDetail200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storesPagination**
> StoresPagination200Response storesPagination(filterLeftSquareBracketDomainRightSquareBracket)

List of Stores

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StoreApi();
final filterLeftSquareBracketDomainRightSquareBracket = filterLeftSquareBracketDomainRightSquareBracket_example; // String | Exact-match filter on a bare host such as \"www.Target.com.au\". Case and a leading \"www.\" are ignored. Unlike filter[domains], this does not partial match.

try {
    final result = api_instance.storesPagination(filterLeftSquareBracketDomainRightSquareBracket);
    print(result);
} catch (e) {
    print('Exception when calling StoreApi->storesPagination: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filterLeftSquareBracketDomainRightSquareBracket** | **String**| Exact-match filter on a bare host such as \"www.Target.com.au\". Case and a leading \"www.\" are ignored. Unlike filter[domains], this does not partial match. | [optional] 

### Return type

[**StoresPagination200Response**](StoresPagination200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **storesUpdate**
> Object storesUpdate(id, updateStoreRequest)

Update Store

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = StoreApi();
final id = id_example; // String | 
final updateStoreRequest = UpdateStoreRequest(); // UpdateStoreRequest | 

try {
    final result = api_instance.storesUpdate(id, updateStoreRequest);
    print(result);
} catch (e) {
    print('Exception when calling StoreApi->storesUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateStoreRequest** | [**UpdateStoreRequest**](UpdateStoreRequest.md)|  | [optional] 

### Return type

[**Object**](Object.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

