# priceticker_api.model.MetaExtractionResource

## Load the model package
```dart
import 'package:priceticker_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**title** | **String** |  | 
**price** | **String** |  | 
**currency** | [**MetaExtractionResourceCurrency**](MetaExtractionResourceCurrency.md) |  | 
**locale** | **String** |  | 
**image** | **String** |  | 
**description** | **String** |  | 
**availability** | **String** |  | 
**store** | [**Map<String, StoreResource>**](StoreResource.md) |  | [default to const {}]
**healing** | **String** | Always present, so a client can explain a thin result (\"AI detection timed out\") rather than silently showing empty fields. | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


