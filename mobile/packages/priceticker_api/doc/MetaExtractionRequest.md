# priceticker_api.model.MetaExtractionRequest

## Load the model package
```dart
import 'package:priceticker_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**url** | **String** |  | 
**heal** | **bool** | Opt in to AI healing. Off by default: healing is slow and may propose a different strategy than the one being tested, so a caller has to ask for it and be prepared to wait (up to the published extraction budget). | [optional] 
**store** | [**MetaExtractionRequestStore**](MetaExtractionRequestStore.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


