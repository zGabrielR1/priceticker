# priceticker_api.api.MetaExtractionApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**metaExtraction**](MetaExtractionApi.md#metaextraction) | **POST** /meta-extraction | Extract meta data from a URL


# **metaExtraction**
> MetaExtraction200Response metaExtraction(metaExtractionRequest)

Extract meta data from a URL

### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = MetaExtractionApi();
final metaExtractionRequest = MetaExtractionRequest(); // MetaExtractionRequest | 

try {
    final result = api_instance.metaExtraction(metaExtractionRequest);
    print(result);
} catch (e) {
    print('Exception when calling MetaExtractionApi->metaExtraction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **metaExtractionRequest** | [**MetaExtractionRequest**](MetaExtractionRequest.md)|  | 

### Return type

[**MetaExtraction200Response**](MetaExtraction200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

