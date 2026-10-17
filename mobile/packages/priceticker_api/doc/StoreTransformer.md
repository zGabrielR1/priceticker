# priceticker_api.model.StoreTransformer

## Load the model package
```dart
import 'package:priceticker_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**name** | **String** |  | 
**slug** | **String** |  | 
**initials** | **String** |  | 
**domains** | [**List<Object>**](Object.md) |  | [default to const []]
**scrapeStrategy** | **String** |  | 
**settings** | [**List<Object>**](Object.md) |  | [default to const []]
**notes** | **String** |  | 
**cookies** | **String** |  | 
**userId** | **int** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**currency** | [**StoreTransformerCurrency**](StoreTransformerCurrency.md) |  | 
**locale** | **String** |  | 
**user** | [**UserResource**](UserResource.md) |  | 
**urls** | [**List<UrlResource>**](UrlResource.md) |  | [default to const []]
**products** | [**List<ProductTransformer>**](ProductTransformer.md) |  | [optional] [default to const []]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


