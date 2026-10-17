# priceticker_api.model.StoreResource

## Load the model package
```dart
import 'package:priceticker_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**name** | **String** |  | 
**slug** | **String** |  | 
**initials** | **String** |  | 
**domains** | [**List<Object>**](Object.md) |  | [default to const []]
**scrapeSettings** | **String** | Exposed as `scrape_settings` in the API; the model attribute is `scrape_strategy`. The name differs intentionally to keep the public contract stable. | 
**settings** | [**List<Object>**](Object.md) |  | [default to const []]
**currency** | [**StoreResourceCurrency**](StoreResourceCurrency.md) |  | 
**locale** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


