# priceticker_api.model.CreateStoreRequest

## Load the model package
```dart
import 'package:priceticker_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**name** | **String** |  | 
**slug** | **String** |  | [optional] 
**initials** | **String** |  | [optional] 
**notes** | **String** |  | [optional] 
**userId** | **int** |  | [optional] 
**settings** | [**CreateStoreRequestSettings**](CreateStoreRequestSettings.md) |  | 
**domains** | [**List<CreateStoreRequestDomainsInner>**](CreateStoreRequestDomainsInner.md) |  | [default to const []]
**scrapeStrategy** | [**CreateStoreRequestScrapeStrategy**](CreateStoreRequestScrapeStrategy.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


