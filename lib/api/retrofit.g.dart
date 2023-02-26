// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://oceanapp.developitech.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<bool> makeTransfer(transferBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(transferBody.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'MakeTransfer',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<SearchResult> findItem(searchBody) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(searchBody.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SearchResult>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, 'FindItem',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SearchResult.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<Branch>> getBranches() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Branch>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GetBranches',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Branch.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Sales>> getSales(dateFilter) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(dateFilter.toJson());
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Sales>>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'GetSales',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Sales.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<TransferMaster>> getReceivedTransfers(branchId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'branchId': branchId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<TransferMaster>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GetReceivedTransfers',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => TransferMaster.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<TransferDetail>> getTransferDetails(blno) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'BLNO': blno};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<TransferDetail>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GetTransferDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => TransferDetail.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<bool> receiveTransfer(receiveTransferDto) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(receiveTransferDto.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'ReceiveTransfer',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<DeviceSettings> getSettings(deviceId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'DeviceId': deviceId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<DeviceSettings>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GetSettings',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = DeviceSettings.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<DeviceSettings>> getDevices() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<DeviceSettings>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GetDevices',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => DeviceSettings.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<bool> saveSettings(deviceSettings) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(deviceSettings.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'SaveSettings',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<List<User>> getOceanUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<User>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'GetOceanUsers',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<bool> saveDevices(devicesSettings) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = devicesSettings.map((e) => e.toJson()).toList();
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'SaveDevices',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<bool> deleteDevice(deviceId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'DeviceId': deviceId};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, 'DeleteDevice',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<Customer> findCustomer(mobileNumber) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'MobileNumber': mobileNumber};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Customer>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'FindCustomer',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = Customer.fromJson(_result.data!);
    return value;
  }

  @override
  Future<bool> addCustomer(customer) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(customer.toJson());
    final _result = await _dio.fetch<bool>(_setStreamType<bool>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, 'AddCustomer',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    return value;
  }

  @override
  Future<List<Invoice>> getSalesInvoices(branchId, fromDate, toDate) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<Invoice>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options,
                    'GetSalesInvoices/${branchId}/${fromDate}/${toDate}',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Invoice.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<InvoiceDetail>> getSalesInvoiceDetails(blno) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'BLNO': blno};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<InvoiceDetail>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, 'GetSalesInvoiceDetails',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => InvoiceDetail.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
