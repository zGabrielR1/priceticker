//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/alert_api.dart';
part 'api/auth_api.dart';
part 'api/client_config_api.dart';
part 'api/device_api.dart';
part 'api/meta_extraction_api.dart';
part 'api/price_history_api.dart';
part 'api/product_source_api.dart';
part 'api/products_api.dart';
part 'api/store_api.dart';
part 'api/tag_api.dart';
part 'api/watch_api.dart';

part 'model/auth_login201_response.dart';
part 'model/auth_login401_response.dart';
part 'model/auth_logout200_response.dart';
part 'model/client_config200_response.dart';
part 'model/client_config200_response_data.dart';
part 'model/client_config200_response_data_capabilities.dart';
part 'model/client_config200_response_data_limits.dart';
part 'model/create_product_request.dart';
part 'model/create_product_source_request.dart';
part 'model/create_product_source_request_extraction_strategy.dart';
part 'model/create_product_source_request_extraction_strategy_list_container.dart';
part 'model/create_store_request.dart';
part 'model/create_store_request_domains_inner.dart';
part 'model/create_store_request_scrape_strategy.dart';
part 'model/create_store_request_scrape_strategy_image.dart';
part 'model/create_store_request_settings.dart';
part 'model/create_store_request_settings_locale_settings.dart';
part 'model/create_tag_request.dart';
part 'model/login_request.dart';
part 'model/meta_extraction200_response.dart';
part 'model/meta_extraction_request.dart';
part 'model/meta_extraction_request_store.dart';
part 'model/meta_extraction_request_store_domains_inner.dart';
part 'model/meta_extraction_request_store_scrape_strategy.dart';
part 'model/meta_extraction_request_store_scrape_strategy_title.dart';
part 'model/meta_extraction_request_store_settings.dart';
part 'model/meta_extraction_request_store_settings_locale_settings.dart';
part 'model/meta_extraction_resource.dart';
part 'model/meta_extraction_resource_currency.dart';
part 'model/product_source_results_transformer.dart';
part 'model/product_source_status.dart';
part 'model/product_source_transformer.dart';
part 'model/product_source_type.dart';
part 'model/product_sources_create201_response.dart';
part 'model/product_sources_detail200_response.dart';
part 'model/product_sources_detail200_response_any_of.dart';
part 'model/product_sources_pagination200_response.dart';
part 'model/product_sources_search200_response.dart';
part 'model/product_sources_search_all200_response.dart';
part 'model/product_transformer.dart';
part 'model/products_create201_response.dart';
part 'model/products_detail200_response.dart';
part 'model/products_detail200_response_any_of.dart';
part 'model/products_pagination200_response.dart';
part 'model/statuses.dart';
part 'model/store_resource.dart';
part 'model/store_resource_currency.dart';
part 'model/store_transformer.dart';
part 'model/store_transformer_currency.dart';
part 'model/stores_create201_response.dart';
part 'model/stores_detail200_response.dart';
part 'model/stores_detail200_response_any_of.dart';
part 'model/stores_pagination200_response.dart';
part 'model/sync_product_tags_request.dart';
part 'model/tag_transformer.dart';
part 'model/tags_create201_response.dart';
part 'model/tags_detail200_response.dart';
part 'model/tags_detail200_response_any_of.dart';
part 'model/tags_pagination200_response.dart';
part 'model/update_product_request.dart';
part 'model/update_product_source_request.dart';
part 'model/update_product_source_request_extraction_strategy.dart';
part 'model/update_product_source_request_extraction_strategy_list_container.dart';
part 'model/update_store_request.dart';
part 'model/update_store_request_scrape_strategy.dart';
part 'model/update_store_request_scrape_strategy_image.dart';
part 'model/update_store_request_scrape_strategy_price.dart';
part 'model/update_store_request_settings.dart';
part 'model/update_tag_request.dart';
part 'model/url_resource.dart';
part 'model/user_resource.dart';
part 'model/v1_alerts_index200_response.dart';
part 'model/v1_alerts_read200_response.dart';
part 'model/v1_auth_revoke200_response.dart';
part 'model/v1_auth_token200_response.dart';
part 'model/v1_auth_token_request.dart';
part 'model/v1_devices_destroy204_response.dart';
part 'model/v1_devices_destroy403_response.dart';
part 'model/v1_devices_store_request.dart';
part 'model/watch.dart';
part 'model/watch_type.dart';
part 'model/watches_show200_response.dart';
part 'model/watches_store_request.dart';
part 'model/watches_update_request.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
