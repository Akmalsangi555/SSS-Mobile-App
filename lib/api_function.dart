import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sssmobileapp/config/style.dart';
import 'package:sssmobileapp/utils/api_url/app_urls.dart';

class ApiResponse {
  final int statusCode;
  final dynamic data;
  ApiResponse(this.statusCode, this.data);
}

class ApiService {
  static String? appVersion;
  static String _token = '';
  static String get device => Platform.isIOS
      ? 'IOS'
      : Platform.isAndroid
          ? 'Android'
          : 'other';
  // Live Server

  static String get token => _token;
  static set setToken(String gToken) {
    _token = gToken;
  }

  // static setAppVersion() async {
  //   packageInfo = await PackageInfo.fromPlatform();

  //   appVersion = packageInfo!.version;
  //   print({'App Version: $appVersion'});
  // }

  static Future<ApiResponse> get(String endPoint,
      {Map<String, String>? header, Map<String, dynamic>? parameters}) async {
    header ??= {};
    if (token.isNotEmpty) header['Authorization'] = 'Bearer $token';
    if (appVersion != null) header['version'] = appVersion!;
    header['device'] = device;

    final uri = Uri.parse(_join(AppUrls.baseUrl, endPoint));
    final res = await http.get(uri, headers: header);
    final dynamic data = _parseBody(res.body);
    return ApiResponse(res.statusCode, data);
  }

  static Future<ApiResponse> put(String endpoint,
      {Map<String, String>? queryParameters,
      Map<String, String>? headers,
      Map<String, dynamic>? data}) async {
    headers ??= {};
    if (token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    if (appVersion != null) headers['version'] = appVersion!;
    headers['device'] = device;
    headers['Content-Type'] = 'application/json';

    final uri = Uri.parse(_join(AppUrls.baseUrl, endpoint));
    final res = await http.put(uri,
        headers: headers, body: data != null ? jsonEncode(data) : null);
    final dynamic parsed = _parseBody(res.body);
    return ApiResponse(res.statusCode, parsed);
  }

  static Future<ApiResponse> post(String endpoint,
      {Map<String, String>? headers, dynamic data}) async {
    headers ??= {};
    if (token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    if (appVersion != null) headers['version'] = appVersion!;
    headers['device'] = device;
    headers['Content-Type'] = 'application/json';

    final uri = Uri.parse(_join(AppUrls.baseUrl, endpoint));
    final res = await http.post(uri,
        headers: headers, body: data != null ? jsonEncode(data) : null);
    final dynamic parsed = _parseBody(res.body);
    return ApiResponse(res.statusCode, parsed);
  }

  static Future<ApiResponse> delete(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    dynamic data,
  }) async {
    headers ??= {};
    if (token.isNotEmpty) headers['Authorization'] = 'Bearer $token';
    if (appVersion != null) headers['version'] = appVersion!;
    headers['device'] = device;

    final uri = Uri.parse(_join(AppUrls.baseUrl, endpoint));
    final res = await http.delete(uri, headers: headers);
    final dynamic parsed = _parseBody(res.body);
    return ApiResponse(res.statusCode, parsed);
  }

  static showDialogOnApi(context, dialog,
      {Widget? icon, Color? backgroundColor, Color? textColor}) {
    // Navigator.pop(context);
    if (dialog != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: RichText(
          text: TextSpan(
            children: [
              if (icon != null) WidgetSpan(child: icon),
              TextSpan(
                  text: dialog,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: backgroundColor != null ? 14 : 16,
                    fontFamily: 'PPMori',
                  ))
            ],
          ),
          textAlign: TextAlign.center,
        ),
        dismissDirection: DismissDirection.up,
        backgroundColor: backgroundColor ?? AppTheme.backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        margin: EdgeInsets.only(
            // top: 20,
            bottom: MediaQuery.sizeOf(context).height - 144,
            right: 20,
            left: 20),
      ));
    }
    // ScaffoldMessenger.of(context).showMaterialBanner(
    //   MaterialBanner(
    //     backgroundColor: blackColor,
    //     content: Text(dialog),
    //     actions: [
    //       GCFilledButton(
    //           size: Size(50, 30),
    //           onPressed: () {
    //             ScaffoldMessenger.of(context).clearMaterialBanners();
    //           },
    //           widget: Text('OK'))
    //     ],
    //     onVisible: () {
    //       Future.delayed(Duration(seconds: 2)).then(
    //           (value) => ScaffoldMessenger.of(context).clearMaterialBanners());
    //     },
    //   ),
    // );
  }

  static showSnackBarOnDialog(BuildContext context, String title,
      {Widget? icon, Color? backgroundColor, Color? textColor}) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: context,
        builder: (dc) {
          Future.delayed(const Duration(seconds: 3))
              .then((value) => Navigator.pop(dc));
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            alignment: Alignment.topCenter,
            insetPadding: const EdgeInsets.all(20).copyWith(top: 50),
            contentPadding: const EdgeInsets.all(20),
            backgroundColor: backgroundColor ?? AppTheme.backgroundColor,
            shadowColor: Colors.transparent,
            content: RichText(
              text: TextSpan(
                children: [
                  if (icon != null) WidgetSpan(child: icon),
                  TextSpan(
                      text: title,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontSize: backgroundColor != null ? 14 : 16,
                        fontFamily: 'PPMori',
                      ))
                ],
              ),
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  static dynamic _parseBody(String body) {
    if (body.isEmpty) return null;
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }

  static String _join(String base, String endpoint) {
    final b = base.endsWith('/') ? base.substring(0, base.length - 1) : base;
    final e = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;
    return '$b/$e';
  }
}
