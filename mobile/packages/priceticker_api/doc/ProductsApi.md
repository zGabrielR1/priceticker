# priceticker_api.api.ProductsApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**productsCreate**](ProductsApi.md#productscreate) | **POST** /products | Create Product
[**productsDelete**](ProductsApi.md#productsdelete) | **DELETE** /products/{id} | Delete Product
[**productsDetachTag**](ProductsApi.md#productsdetachtag) | **DELETE** /products/{id}/tags/{tagId} | Remove Product Tag
[**productsDetail**](ProductsApi.md#productsdetail) | **GET** /products/{id} | Show Product
[**productsPagination**](ProductsApi.md#productspagination) | **GET** /products | List of Products
[**productsSyncTags**](ProductsApi.md#productssynctags) | **PUT** /products/{id}/tags | Set Product Tags
[**productsUpdate**](ProductsApi.md#productsupdate) | **PUT** /products/{id} | Update Product


# **productsCreate**
> ProductsCreate201Response productsCreate(createProductRequest)

Create Product

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final createProductRequest = CreateProductRequest(); // CreateProductRequest | 

try {
    final result = api_instance.productsCreate(createProductRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsCreate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **createProductRequest** | [**CreateProductRequest**](CreateProductRequest.md)|  | 

### Return type

[**ProductsCreate201Response**](ProductsCreate201Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productsDelete**
> String productsDelete(id)

Delete Product

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final id = id_example; // String | 

try {
    final result = api_instance.productsDelete(id);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsDelete: $e\n');
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

# **productsDetachTag**
> String productsDetachTag(id, tagId)

Remove Product Tag

Removes one tag from the product. The tag record itself is not deleted.

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final id = id_example; // String | 
final tagId = tagId_example; // String | 

try {
    final result = api_instance.productsDetachTag(id, tagId);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsDetachTag: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **tagId** | **String**|  | 

### Return type

**String**

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productsDetail**
> ProductsDetail200Response productsDetail(id, currentUrl)

Show Product

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final id = id_example; // String | 
final currentUrl = currentUrl_example; // String | Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean, true for the listing matching this page.

try {
    final result = api_instance.productsDetail(id, currentUrl);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsDetail: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **currentUrl** | **String**| Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean, true for the listing matching this page. | [optional] 

### Return type

[**ProductsDetail200Response**](ProductsDetail200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productsPagination**
> ProductsPagination200Response productsPagination(filterLeftSquareBracketUrlRightSquareBracket, currentUrl)

List of Products

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final filterLeftSquareBracketUrlRightSquareBracket = filterLeftSquareBracketUrlRightSquareBracket_example; // String | Return products tracking this page URL. Matching is normalised: scheme, port, \"www.\", trailing slashes, casing and tracking parameters are ignored.
final currentUrl = currentUrl_example; // String | Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean.

try {
    final result = api_instance.productsPagination(filterLeftSquareBracketUrlRightSquareBracket, currentUrl);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsPagination: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **filterLeftSquareBracketUrlRightSquareBracket** | **String**| Return products tracking this page URL. Matching is normalised: scheme, port, \"www.\", trailing slashes, casing and tracking parameters are ignored. | [optional] 
 **currentUrl** | **String**| Raw URL of the page being viewed. When supplied, each price_cache entry gains an `is_current` boolean. | [optional] 

### Return type

[**ProductsPagination200Response**](ProductsPagination200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productsSyncTags**
> Object productsSyncTags(id, syncProductTagsRequest)

Set Product Tags

Replaces the product's tags with the given tag ids. Send an empty list to remove all tags.

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final id = id_example; // String | 
final syncProductTagsRequest = SyncProductTagsRequest(); // SyncProductTagsRequest | 

try {
    final result = api_instance.productsSyncTags(id, syncProductTagsRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsSyncTags: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **syncProductTagsRequest** | [**SyncProductTagsRequest**](SyncProductTagsRequest.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **productsUpdate**
> Object productsUpdate(id, updateProductRequest)

Update Product

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = ProductsApi();
final id = id_example; // String | 
final updateProductRequest = UpdateProductRequest(); // UpdateProductRequest | 

try {
    final result = api_instance.productsUpdate(id, updateProductRequest);
    print(result);
} catch (e) {
    print('Exception when calling ProductsApi->productsUpdate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**|  | 
 **updateProductRequest** | [**UpdateProductRequest**](UpdateProductRequest.md)|  | 

### Return type

[**Object**](Object.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

