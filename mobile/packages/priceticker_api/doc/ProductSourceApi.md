# priceticker_api.api.ProductSourceApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**productSourcesCreate**](ProductSourceApi.md#productsourcescreate) | **POST** /product-sources | Create Product Source
[**productSourcesDelete**](ProductSourceApi.md#productsourcesdelete) | **DELETE** /product-sources/{id} | Delete Product Source
[**productSourcesDetail**](ProductSourceApi.md#productsourcesdetail) | **GET** /product-sources/{id} | Show Product Source
[**productSourcesPagination**](ProductSourceApi.md#productsourcespagination) | **GET** /product-sources | List of Product Sources
[**productSourcesSearch**](ProductSourceApi.md#productsourcessearch) | **GET** /product-sources/{id}/search/{query} | Search via Product Source
[**productSourcesSearchAll**](ProductSourceApi.md#productsourcessearchall) | **GET** /product-sources/search/{query} | Search all Product Sources
[**productSourcesUpdate**](ProductSourceApi.md#productsourcesupdate) | **PUT** /product-sources/{id} | Update Product Source


# **productSourcesCreate**
> ProductSourcesCreate201Response productSourcesCreate(createProductSourceRequest)

Create Product Source

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();
final createProductSourceRequest = CreateProductSourceRequest(); // CreateProductSourceRequest | 

try {
    final result = api_instance.productSourcesCreate(createProductSourceRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProductSourceRequest** | [**CreateProductSourceRequest**](CreateProductSourceRequest.md)|  | 

### Return type

[**ProductSourcesCreate201Response**](ProductSourcesCreate201Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productSourcesDelete**
> String productSourcesDelete(id)

Delete Product Source

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();
final id = id_example; // String | 

try {
    final result = api_instance.productSourcesDelete(id);
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesDelete: $e\n');
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

# **productSourcesDetail**
> ProductSourcesDetail200Response productSourcesDetail(id)

Show Product Source

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();
final id = id_example; // String | 

try {
    final result = api_instance.productSourcesDetail(id);
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 

### Return type

[**ProductSourcesDetail200Response**](ProductSourcesDetail200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productSourcesPagination**
> ProductSourcesPagination200Response productSourcesPagination()

List of Product Sources

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();

try {
    final result = api_instance.productSourcesPagination();
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesPagination: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ProductSourcesPagination200Response**](ProductSourcesPagination200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productSourcesSearch**
> ProductSourcesSearch200Response productSourcesSearch(id, query)

Search via Product Source

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();
final id = id_example; // String | 
final query = query_example; // String | 

try {
    final result = api_instance.productSourcesSearch(id, query);
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesSearch: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **query** | **String**|  | 

### Return type

[**ProductSourcesSearch200Response**](ProductSourcesSearch200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productSourcesSearchAll**
> ProductSourcesSearchAll200Response productSourcesSearchAll(query)

Search all Product Sources

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();
final query = query_example; // String | 

try {
    final result = api_instance.productSourcesSearchAll(query);
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesSearchAll: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **query** | **String**|  | 

### Return type

[**ProductSourcesSearchAll200Response**](ProductSourcesSearchAll200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productSourcesUpdate**
> Object productSourcesUpdate(id, updateProductSourceRequest)

Update Product Source

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductSourceApi();
final id = id_example; // String | 
final updateProductSourceRequest = UpdateProductSourceRequest(); // UpdateProductSourceRequest | 

try {
    final result = api_instance.productSourcesUpdate(id, updateProductSourceRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProductSourceApi->productSourcesUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateProductSourceRequest** | [**UpdateProductSourceRequest**](UpdateProductSourceRequest.md)|  | [optional] 

### Return type

[**Object**](Object.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

