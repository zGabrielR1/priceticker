# priceticker_api.api.TagApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**tagsCreate**](TagApi.md#tagscreate) | **POST** /tags | Create Tag
[**tagsDelete**](TagApi.md#tagsdelete) | **DELETE** /tags/{id} | Delete Tag
[**tagsDetail**](TagApi.md#tagsdetail) | **GET** /tags/{id} | Show Tag
[**tagsPagination**](TagApi.md#tagspagination) | **GET** /tags | List of Tags
[**tagsUpdate**](TagApi.md#tagsupdate) | **PUT** /tags/{id} | Update Tag


# **tagsCreate**
> TagsCreate201Response tagsCreate(createTagRequest)

Create Tag

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TagApi();
final createTagRequest = CreateTagRequest(); // CreateTagRequest | 

try {
    final result = api_instance.tagsCreate(createTagRequest);
    print(result);
} catch (e) {
    print('Exception when calling TagApi->tagsCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createTagRequest** | [**CreateTagRequest**](CreateTagRequest.md)|  | 

### Return type

[**TagsCreate201Response**](TagsCreate201Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagsDelete**
> String tagsDelete(id)

Delete Tag

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TagApi();
final id = id_example; // String | 

try {
    final result = api_instance.tagsDelete(id);
    print(result);
} catch (e) {
    print('Exception when calling TagApi->tagsDelete: $e\n');
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

# **tagsDetail**
> TagsDetail200Response tagsDetail(id)

Show Tag

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TagApi();
final id = id_example; // String | 

try {
    final result = api_instance.tagsDetail(id);
    print(result);
} catch (e) {
    print('Exception when calling TagApi->tagsDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**TagsDetail200Response**](TagsDetail200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagsPagination**
> TagsPagination200Response tagsPagination()

List of Tags

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TagApi();

try {
    final result = api_instance.tagsPagination();
    print(result);
} catch (e) {
    print('Exception when calling TagApi->tagsPagination: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**TagsPagination200Response**](TagsPagination200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **tagsUpdate**
> Object tagsUpdate(id, updateTagRequest)

Update Tag

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = TagApi();
final id = id_example; // String | 
final updateTagRequest = UpdateTagRequest(); // UpdateTagRequest | 

try {
    final result = api_instance.tagsUpdate(id, updateTagRequest);
    print(result);
} catch (e) {
    print('Exception when calling TagApi->tagsUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateTagRequest** | [**UpdateTagRequest**](UpdateTagRequest.md)|  | [optional] 

### Return type

[**Object**](Object.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

