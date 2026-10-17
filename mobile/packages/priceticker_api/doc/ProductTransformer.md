# priceticker_api.model.ProductTransformer

## Load the model package
```dart
import 'package:priceticker_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **int** |  | 
**title** | **String** |  | 
**unitOfMeasure** | **String** |  | 
**image** | **String** |  | 
**status** | [**Statuses**](Statuses.md) |  | 
**weight** | **int** |  | 
**currentPrice** | **num** |  | 
**notifyPrice** | **num** |  | 
**notifyPercent** | **num** |  | 
**notifyInStock** | **bool** |  | 
**refreshInterval** | **int** |  | 
**nextCheckAt** | [**DateTime**](DateTime.md) |  | 
**paused** | **bool** |  | 
**favourite** | **bool** |  | 
**onlyOfficial** | **int** |  | 
**priceCache** | [**List<Object>**](Object.md) |  | [default to const []]
**ignoredUrls** | [**List<Object>**](Object.md) |  | [default to const []]
**userId** | **int** |  | 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | 
**tags** | [**List<TagTransformer>**](TagTransformer.md) |  | [default to const []]
**user** | [**UserResource**](UserResource.md) |  | 
**insights** | **String** |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


