# priceticker_api.api.PriceHistoryApi

## Load the API package
```dart
import 'package:priceticker_api/api.dart';
```

All URIs are relative to *http://localhost/api*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1ProductsPrices**](PriceHistoryApi.md#v1productsprices) | **GET** /v1/products/{product}/prices | 


# **v1ProductsPrices**
> V1AlertsIndex200Response v1ProductsPrices(product)



### Example
```dart
import 'package:priceticker_api/api.dart';
// TODO Configure HTTP Bearer authorization: http
// Case 1. Use String Token
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken('YOUR_ACCESS_TOKEN');
// Case 2. Use Function which generate token.
// String yourTokenGeneratorFunction() { ... }
//defaultApiClient.getAuthentication<HttpBearerAuth>('http').setAccessToken(yourTokenGeneratorFunction);

final api_instance = PriceHistoryApi();
final product = 56; // int | The product ID

try {
    final result = api_instance.v1ProductsPrices(product);
    print(result);
} catch (e) {
    print('Exception when calling PriceHistoryApi->v1ProductsPrices: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **product** | **int**| The product ID | 

### Return type

[**V1AlertsIndex200Response**](V1AlertsIndex200Response.md)

### Authorization

[http](../README.md#http)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

