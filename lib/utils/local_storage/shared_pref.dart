
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sssmobileapp/model/auth_models/user_content_model.dart';

class SharedPrefs {
  // ==================== User Authentication Keys ====================
  static const _userKey = 'logged_user';
  static const _tokenKey = 'access_token';
  static const _isLoggedInKey = 'is_logged_in';
  static const _guardIdKey = 'guard_id';
  static const _userIdKey = 'user_id';
  static const _guardNameKey = 'guard_name';
  static const _branchIdKey = 'branch_id';
  static const _organizationIdKey = 'organization_id';
  static const _profileTypedKey = 'profile_type';
  static const _guardsTypeIdKey = 'guards_type_id';

  static const String _keyHasSelectedLanguage = 'has_selected_language';
  static const String _languageCodeKey = 'selected_language_code';

  // ==================== Clock In/Out Persistent Keys ====================
  static const _isClockedInKey = 'clock_in_status';
  static const _clockInTimeKey = 'clock_in_time';
  static const _clockInDateTimeKey = 'clock_in_datetime';
  static const _clockInScheduleDetailIdKey = 'clock_in_schedule_id';
  static const _clockInDataKey = 'clock_in_complete_data';
  static const _clockOutTimeKey = 'clock_out_time';
  static const _lastClockActionKey = 'last_clock_action';
  static const _clockInSessionIdKey = 'clock_in_session_id';
  static const _clockInLocationKey = 'clock_in_location';
  static const _clockInNotesKey = 'clock_in_notes';
  static const _clockInDurationKey = 'clock_in_duration';

  // ==================== Background Service Keys ====================
  static const _backgroundServiceRunningKey = 'background_service_running';
  static const _lastBackgroundSyncKey = 'last_background_sync';
  static const _backgroundTaskCountKey = 'background_task_count';

  // ==================== Device & App State Keys ====================
  static const _deviceIdKey = 'device_id';
  static const _appVersionKey = 'app_version';
  static const _lastAppOpenKey = 'last_app_open';
  static const _appLaunchCountKey = 'app_launch_count';
  static const _isFirstLaunchKey = 'is_first_launch';

  // ==================== NFC & Checkpoint Keys ====================
  static const _lastNfcScanKey = 'last_nfc_scan';
  static const _nfcScanHistoryKey = 'nfc_scan_history';
  static const _checkpointStatusKey = 'checkpoint_status';

  // Initialize SharedPreferences
  static Future<void> init() async {
    await SharedPreferences.getInstance();
    print('✅ [SHAREDPREFS] Initialized successfully');
  }

  // ==================== User Management ====================
  /// Save user and token together
  static Future<void> saveUserContent(
      UserContentModel user, {
        String? token,
        String? guardId,
        String? userId,
        String? guardName,
        String? branchId,
        String? organizationId,
        String? guardsTypeId,
      }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Save user as JSON
      print('💾 [SHAREDPREFS] Saving user content...');
      await prefs.setString(_userKey, jsonEncode(user.toJson()));

      if (token != null && token.isNotEmpty) {
        print('💾 [SHAREDPREFS] Saving token...');
        await prefs.setString(_tokenKey, token);
      }

      // Use values from user object if not provided
      final finalGuardId = guardId ?? user.guardsId.toString();
      final finalUserId = userId ?? user.usersProfileId.toString();
      final finalGuardName = guardName ?? user.userName;
      final finalBranchId = branchId ?? user.branchId.toString();
      final finalOrgId = organizationId ?? user.organizationId.toString();
      final finalGuardsTypeId = guardsTypeId ?? user.usersProfileTypeId.toString();

      // Save Guard ID
      if (finalGuardId.isNotEmpty) {
        await prefs.setString(_guardIdKey, finalGuardId);
        print('✅ [SHAREDPREFS] Guard ID saved: $finalGuardId');
      }

      // Save GuardsType ID
      if (finalGuardsTypeId.isNotEmpty) {
        await prefs.setString(_guardsTypeIdKey, finalGuardsTypeId);
        print('✅ [SHAREDPREFS] GuardsType ID saved: $finalGuardsTypeId');
      }

      // Save User ID
      if (finalUserId.isNotEmpty) {
        await prefs.setString(_userIdKey, finalUserId);
        print('✅ [SHAREDPREFS] User ID saved: $finalUserId');
      }

      // Save Guard Name
      if (finalGuardName.isNotEmpty) {
        await prefs.setString(_guardNameKey, finalGuardName);
        print('✅ [SHAREDPREFS] Guard Name saved: $finalGuardName');
      }

      // Save Branch ID
      if (finalBranchId.isNotEmpty) {
        await prefs.setString(_branchIdKey, finalBranchId);
        print('✅ [SHAREDPREFS] Branch ID saved: $finalBranchId');
      }

      // Save Organization ID
      if (finalOrgId.isNotEmpty) {
        await prefs.setString(_organizationIdKey, finalOrgId);
        print('✅ [SHAREDPREFS] Organization ID saved: $finalOrgId');
      }

      // ✅ SAVE PROFILE TYPE
      if (user.profileType != null && user.profileType.isNotEmpty) {
        await prefs.setString(_profileTypedKey, user.profileType);
        print('✅ [SHAREDPREFS] Profile Type saved: ${user.profileType}');
      }

      await prefs.setBool(_isLoggedInKey, true);
      print('✅ [SHAREDPREFS] User content saved successfully');


    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving user: $e');
      rethrow;
    }
  }


  // Call this after successful language selection
  static Future<void> setLanguageSelected() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHasSelectedLanguage, true);
  }

  // Check if user has already selected language
  static Future<bool> hasLanguageBeenSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHasSelectedLanguage) ?? false;
  }

  static Future<void> setLanguageCode(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageCodeKey, code);
      print('💾 Language code saved: $code');
    } catch (e) {
      print('Error saving language code: $e');
    }
  }

  static Future<String?> getLanguageCode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_languageCodeKey);
    } catch (e) {
      print('Error getting language code: $e');
      return null;
    }
  }

  // Call this when user logs out
  static Future<void> onLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyHasSelectedLanguage);
    // Also clear user data, token, etc. (you probably already do this)
  }

  /// Call this when user confirms logout (usually from dialog)
  static Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // ── Critical authentication data ───────────────────────────────
      await prefs.remove(_userKey);
      await prefs.remove(_tokenKey);
      await prefs.remove(_isLoggedInKey);

      // ── User profile & organization related ────────────────────────
      await prefs.remove(_guardIdKey);
      await prefs.remove(_userIdKey);
      await prefs.remove(_guardNameKey);
      await prefs.remove(_branchIdKey);
      await prefs.remove(_organizationIdKey);
      await prefs.remove(_profileTypedKey);
      await prefs.remove(_guardsTypeIdKey);

      // ── Clock in/out session data ──────────────────────────────────
      // Most apps want to **clear clock session** on logout
      await prefs.remove(_isClockedInKey);
      await prefs.remove(_clockInTimeKey);
      await prefs.remove(_clockInDateTimeKey);
      await prefs.remove(_clockInScheduleDetailIdKey);
      await prefs.remove(_clockInDataKey);
      await prefs.remove(_clockOutTimeKey);
      await prefs.remove(_lastClockActionKey);
      await prefs.remove(_clockInSessionIdKey);
      await prefs.remove(_clockInLocationKey);
      await prefs.remove(_clockInNotesKey);
      await prefs.remove(_clockInDurationKey);

      // ── Check call related (very important to clean) ───────────────
      await clearAllCheckCallData();

      // ── Background service flags ───────────────────────────────────
      await prefs.setBool(_backgroundServiceRunningKey, false);
      // You may also want to stop any background service here

      // ── Optional: keep these if you want to remember language/theme ─
      // await prefs.remove(_keyHasSelectedLanguage);
      // await prefs.remove(_languageCodeKey);

      print('🚪 [LOGOUT] User successfully logged out - sensitive data cleared');

    } catch (e) {
      print('❌ [LOGOUT] Error during logout process: $e');
      // Optionally rethrow or handle error
    }
  }

  /// Get GuardsType_ID
  static Future<String?> getGuardsTypeId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_guardsTypeIdKey);
    } catch (e) {
      print('Error getting guards type id: $e');
      return null;
    }
  }

  /// Clear GuardsType_ID
  static Future<void> clearGuardsTypeId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_guardsTypeIdKey);
      print('🗑️ [SHAREDPREFS] GuardsType_ID cleared');
    } catch (e) {
      print('Error clearing guards type id: $e');
    }
  }

  /// Save just the user (without token)
  static Future<void> saveUser(UserContentModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
      await prefs.setBool(_isLoggedInKey, true);
      // Also save profile type when saving user
      if (user.profileType != null && user.profileType.isNotEmpty) {
        await prefs.setString(_profileTypedKey, user.profileType);
      }
    } catch (e) {
      print('Error saving user: $e');
      rethrow;
    }
  }

  static Future<UserContentModel?> getUserContent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_userKey);
      if (jsonString == null) return null;
      final Map<String, dynamic> map = jsonDecode(jsonString);
      return UserContentModel.fromJson(map);
    } catch (e) {
      print('Error getting user: $e');
      return null;
    }
  }



  // ==================== Background Service Management ====================

  static Future<void> setBackgroundServiceRunning(bool isRunning) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_backgroundServiceRunningKey, isRunning);
      if (isRunning) {
        await prefs.setString(_lastBackgroundSyncKey, DateTime.now().toIso8601String());
      }
    } catch (e) {
      print('❌ [SHAREDPREFS] Error setting background service: $e');
    }
  }

  static Future<bool> isBackgroundServiceRunning() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_backgroundServiceRunningKey) ?? false;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting background service status: $e');
      return false;
    }
  }

  static Future<void> incrementBackgroundTaskCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final current = prefs.getInt(_backgroundTaskCountKey) ?? 0;
      await prefs.setInt(_backgroundTaskCountKey, current + 1);
    } catch (e) {
      print('❌ [SHAREDPREFS] Error incrementing task count: $e');
    }
  }

  // ==================== Profile Type Management ====================
  static Future<String?> getProfileType() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_profileTypedKey);
    } catch (e) {
      print('Error getting profile type: $e');
      return null;
    }
  }

  static Future<void> setProfileType(String profileType) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_profileTypedKey, profileType);
      print('💾 [SHAREDPREFS] Profile Type set: $profileType');
    } catch (e) {
      print('Error setting profile type: $e');
    }
  }

  // ==================== Token Management ====================
  static Future<String?> getAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_tokenKey);
    } catch (e) {
      print('Error getting access token: $e');
      return null;
    }
  }

  static Future<void> setAccessToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
    } catch (e) {
      print('Error setting access token: $e');
    }
  }

  // ==================== Guard ID Management ====================
  static Future<String?> getGuardId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_guardIdKey);
    } catch (e) {
      print('Error getting guard id: $e');
      return null;
    }
  }

  static Future<void> setGuardId(String guardId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_guardIdKey, guardId);
      print('💾 [SHAREDPREFS] Guard ID set: $guardId');
    } catch (e) {
      print('Error setting guard id: $e');
    }
  }

  // ==================== User ID Management ====================
  static Future<String?> getUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userIdKey);
    } catch (e) {
      print('Error getting user id: $e');
      return null;
    }
  }

  static Future<void> setUserId(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userIdKey, userId);
      print('💾 [SHAREDPREFS] User ID set: $userId');
    } catch (e) {
      print('Error setting user id: $e');
    }
  }

  // ==================== Guard Name Management ====================
  static Future<String?> getGuardName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_guardNameKey);
    } catch (e) {
      print('Error getting guard name: $e');
      return null;
    }
  }

  static Future<void> setGuardName(String guardName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_guardNameKey, guardName);
      print('💾 [SHAREDPREFS] Guard Name set: $guardName');
    } catch (e) {
      print('Error setting guard name: $e');
    }
  }

  // ==================== Branch ID Management ====================
  static Future<String?> getBranchId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_branchIdKey);
    } catch (e) {
      print('Error getting branch id: $e');
      return null;
    }
  }

  static Future<void> setBranchId(String branchId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_branchIdKey, branchId);
      print('💾 [SHAREDPREFS] Branch ID set: $branchId');
    } catch (e) {
      print('Error setting branch id: $e');
    }
  }

  // ==================== Organization ID Management ====================
  static Future<String?> getOrganizationId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_organizationIdKey);
    } catch (e) {
      print('Error getting organization id: $e');
      return null;
    }
  }

  static Future<void> setOrganizationId(String organizationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_organizationIdKey, organizationId);
      print('💾 [SHAREDPREFS] Organization ID set: $organizationId');
    } catch (e) {
      print('Error setting organization id: $e');
    }
  }

  // ==================== Login Status ====================
  static Future<bool> isLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_isLoggedInKey) ?? false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  // ==================== Clear User Data ====================
  static Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
      await prefs.remove(_tokenKey);
      await prefs.remove(_guardIdKey);
      await prefs.remove(_userIdKey);
      await prefs.remove(_guardNameKey);
      await prefs.remove(_branchIdKey);
      await prefs.remove(_organizationIdKey);
      await prefs.remove(_profileTypedKey);
      await prefs.remove(_guardsTypeIdKey);
      await prefs.setBool(_isLoggedInKey, false);



      print('🗑️  [SHAREDPREFS] All user data cleared');
    } catch (e) {
      print('Error clearing user: $e');
    }
  }

  // ==================== Generic Methods ====================
  static Future<void> setBool(String key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
    } catch (e) {
      print('Error setting bool: $e');
    }
  }

  static Future<bool?> getBool(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(key);
    } catch (e) {
      print('Error getting bool: $e');
      return null;
    }
  }

  static Future<void> setString(String key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      print('Error setting string: $e');
    }
  }

  static Future<String?> getString(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      print('Error getting string: $e');
      return null;
    }
  }

  static Future<void> setInt(String key, int value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
    } catch (e) {
      print('Error setting int: $e');
    }
  }

  static Future<int?> getInt(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(key);
    } catch (e) {
      print('Error getting int: $e');
      return null;
    }
  }

  static Future<void> setDouble(String key, double value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(key, value);
    } catch (e) {
      print('Error setting double: $e');
    }
  }

  static Future<double?> getDouble(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getDouble(key);
    } catch (e) {
      print('Error getting double: $e');
      return null;
    }
  }

  static Future<void> setStringList(String key, List<String> value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(key, value);
    } catch (e) {
      print('Error setting string list: $e');
    }
  }

  static Future<List<String>?> getStringList(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(key);
    } catch (e) {
      print('Error getting string list: $e');
      return null;
    }
  }

  static Future<void> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(key);
    } catch (e) {
      print('Error removing key: $e');
    }
  }

  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      print('🗑️  [SHAREDPREFS] All preferences cleared');
    } catch (e) {
      print('Error clearing all: $e');
    }
  }

  /// Get all checkpoint statuses for a schedule
  static Future<Map<String, dynamic>> getAllCheckpointStatuses(int scheduleDetailId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '${_checkpointStatusKey}_${scheduleDetailId}';

      final existingJson = prefs.getString(key) ?? '{}';
      return jsonDecode(existingJson);
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting all checkpoint statuses: $e');
      return {};
    }
  }


  // ==================== Check Call Management ===============
  // Add these methods to your existing SharedPrefs class in lib/utils/local_storage/shared_pref.dart

// ==================== Check Call Management ====================

  static const _checkCallStatusKey = 'check_call_status';
  static const _lastCheckCallTimeKey = 'last_check_call_time';
  static const _checkCallHistoryKey = 'check_call_history';
  static const _pendingCheckCallKey = 'pending_check_call';
  static const _checkCallMediaKey = 'check_call_media';
  static const _checkCallCommentKey = 'check_call_comment';
  static const _checkCallLocationKey = 'check_call_location';
  static const _checkCallCounterKey = 'check_call_counter';

  /// Save current check call status
  static Future<void> saveCheckCallStatus({
    required int checkCallScheduleId,
    required int scheduleDetailId,
    required String status,
    String? locationName,
    DateTime? scheduledTime,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final data = {
        'checkCallScheduleId': checkCallScheduleId,
        'scheduleDetailId': scheduleDetailId,
        'status': status,
        'locationName': locationName ?? '',
        'scheduledTime': scheduledTime?.toIso8601String() ?? '',
        'savedAt': DateTime.now().toIso8601String(),
      };

      await prefs.setString(_checkCallStatusKey, jsonEncode(data));
      print('✅ [SHAREDPREFS] Check call status saved: $status');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving check call status: $e');
    }
  }

  /// Get current check call status
  static Future<Map<String, dynamic>?> getCheckCallStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_checkCallStatusKey);

      if (json != null && json.isNotEmpty) {
        return jsonDecode(json);
      }

      return null;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting check call status: $e');
      return null;
    }
  }

  /// Save check call submission time
  static Future<void> saveLastCheckCallTime(DateTime time) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastCheckCallTimeKey, time.toIso8601String());
      print('✅ [SHAREDPREFS] Last check call time saved');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving last check call time: $e');
    }
  }

  /// Get last check call submission time
  static Future<DateTime?> getLastCheckCallTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timeStr = prefs.getString(_lastCheckCallTimeKey);

      if (timeStr != null && timeStr.isNotEmpty) {
        return DateTime.parse(timeStr);
      }

      return null;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting last check call time: $e');
      return null;
    }
  }

  /// Save check call history (local cache)
  static Future<void> saveCheckCallHistory(List<Map<String, dynamic>> history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_checkCallHistoryKey, jsonEncode(history));
      print('✅ [SHAREDPREFS] Check call history saved (${history.length} items)');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving check call history: $e');
    }
  }

  /// Get cached check call history
  static Future<List<Map<String, dynamic>>?> getCheckCallHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_checkCallHistoryKey);

      if (json != null && json.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(json);
        return decoded.cast<Map<String, dynamic>>();
      }

      return null;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting check call history: $e');
      return null;
    }
  }

  /// Save pending check call (for offline use)
  static Future<void> savePendingCheckCall({
    required int checkCallScheduleId,
    required int scheduleDetailId,
    required int guardId,
    required int locationId,
    required DateTime scheduledTime,
    required double latitude,
    required double longitude,
    String? comment,
    List<String>? mediaFileNames,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final data = {
        'checkCallScheduleId': checkCallScheduleId,
        'scheduleDetailId': scheduleDetailId,
        'guardId': guardId,
        'locationId': locationId,
        'scheduledTime': scheduledTime.toIso8601String(),
        'submittedTime': DateTime.now().toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'comment': comment ?? '',
        'mediaFileNames': mediaFileNames ?? [],
        'isPending': true,
      };

      await prefs.setString(_pendingCheckCallKey, jsonEncode(data));
      print('✅ [SHAREDPREFS] Pending check call saved');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving pending check call: $e');
    }
  }

  /// Get pending check call
  static Future<Map<String, dynamic>?> getPendingCheckCall() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_pendingCheckCallKey);

      if (json != null && json.isNotEmpty) {
        return jsonDecode(json);
      }

      return null;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting pending check call: $e');
      return null;
    }
  }

  /// Clear pending check call after successful submission
  static Future<void> clearPendingCheckCall() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_pendingCheckCallKey);
      print('🗑️ [SHAREDPREFS] Pending check call cleared');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error clearing pending check call: $e');
    }
  }

  /// Save check call media filenames
  static Future<void> saveCheckCallMedia(List<String> mediaFileNames) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_checkCallMediaKey, mediaFileNames);
      print('✅ [SHAREDPREFS] Check call media saved (${mediaFileNames.length} files)');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving check call media: $e');
    }
  }

  /// Get check call media filenames
  static Future<List<String>?> getCheckCallMedia() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getStringList(_checkCallMediaKey);
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting check call media: $e');
      return null;
    }
  }

  /// Save check call comment
  static Future<void> saveCheckCallComment(String comment) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_checkCallCommentKey, comment);
      print('✅ [SHAREDPREFS] Check call comment saved');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving check call comment: $e');
    }
  }

  /// Get check call comment
  static Future<String?> getCheckCallComment() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_checkCallCommentKey);
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting check call comment: $e');
      return null;
    }
  }

  /// Save check call location (GPS coordinates)
  static Future<void> saveCheckCallLocation({
    required double latitude,
    required double longitude,
    String? address,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final data = {
        'latitude': latitude,
        'longitude': longitude,
        'address': address ?? '',
        'savedAt': DateTime.now().toIso8601String(),
      };

      await prefs.setString(_checkCallLocationKey, jsonEncode(data));
      print('✅ [SHAREDPREFS] Check call location saved ($latitude, $longitude)');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error saving check call location: $e');
    }
  }

  /// Get check call location
  static Future<Map<String, dynamic>?> getCheckCallLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = prefs.getString(_checkCallLocationKey);

      if (json != null && json.isNotEmpty) {
        return jsonDecode(json);
      }

      return null;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting check call location: $e');
      return null;
    }
  }

  /// Increment check call counter (for statistics)
  static Future<int> incrementCheckCallCounter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final current = prefs.getInt(_checkCallCounterKey) ?? 0;
      final newCount = current + 1;

      await prefs.setInt(_checkCallCounterKey, newCount);
      print('✅ [SHAREDPREFS] Check call counter incremented: $newCount');

      return newCount;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error incrementing check call counter: $e');
      return 0;
    }
  }

  /// Get check call counter
  static Future<int> getCheckCallCounter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_checkCallCounterKey) ?? 0;
    } catch (e) {
      print('❌ [SHAREDPREFS] Error getting check call counter: $e');
      return 0;
    }
  }

  /// Reset check call counter (daily reset)
  static Future<void> resetCheckCallCounter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_checkCallCounterKey, 0);
      print('🔄 [SHAREDPREFS] Check call counter reset');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error resetting check call counter: $e');
    }
  }

  /// Clear all check call related data
  static Future<void> clearAllCheckCallData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove(_checkCallStatusKey);
      await prefs.remove(_lastCheckCallTimeKey);
      await prefs.remove(_checkCallHistoryKey);
      await prefs.remove(_pendingCheckCallKey);
      await prefs.remove(_checkCallMediaKey);
      await prefs.remove(_checkCallCommentKey);
      await prefs.remove(_checkCallLocationKey);
      await prefs.remove(_checkCallCounterKey);

      print('🗑️ [SHAREDPREFS] All check call data cleared');
    } catch (e) {
      print('❌ [SHAREDPREFS] Error clearing check call data: $e');
    }
  }
  // ==================== Debug Helper ====================
  static Future<void> printAllSavedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print('\n╔══════════════════════════════════════════════════╗');
      print('║   📋 COMPLETE SAVED DATA DUMP                     ║');
      print('╠══════════════════════════════════════════════════╣');
      print('║              USER AUTHENTICATION                  ║');
      print('╠══════════════════════════════════════════════════╣');
      print('Token: ${prefs.getString(_tokenKey)?.substring(0, 20)}...');
      print('Guard ID: ${prefs.getString(_guardIdKey) ?? 'NOT SET'}');
      print('User ID: ${prefs.getString(_userIdKey) ?? 'NOT SET'}');
      print('Guard Name: ${prefs.getString(_guardNameKey) ?? 'NOT SET'}');
      print('Branch ID: ${prefs.getString(_branchIdKey) ?? 'NOT SET'}');
      print('Organization ID: ${prefs.getString(_organizationIdKey) ?? 'NOT SET'}');
      print('Profile Type: ${prefs.getString(_profileTypedKey) ?? 'NOT SET'}');
      print('Is Logged In: ${prefs.getBool(_isLoggedInKey) ?? false}');

      print('╠══════════════════════════════════════════════════╣');
      print('║              CLOCK IN/OUT STATUS                  ║');
      print('╠══════════════════════════════════════════════════╣');
      print('Clocked In: ${prefs.getBool(_isClockedInKey) ?? false}');
      print('Schedule ID: ${prefs.getString(_clockInScheduleDetailIdKey) ?? 'NOT SET'}');
      print('Clock In Time: ${prefs.getString(_clockInTimeKey) ?? 'NOT SET'}');
      print('Clock Out Time: ${prefs.getString(_clockOutTimeKey) ?? 'NOT SET'}');
      print('Last Action: ${prefs.getString(_lastClockActionKey) ?? 'NOT SET'}');

      print('╠══════════════════════════════════════════════════╣');
      print('║              BACKGROUND SERVICE                   ║');
      print('╠══════════════════════════════════════════════════╣');
      print('Service Running: ${prefs.getBool(_backgroundServiceRunningKey) ?? false}');
      print('Last Sync: ${prefs.getString(_lastBackgroundSyncKey) ?? 'NOT SET'}');
      print('Task Count: ${prefs.getInt(_backgroundTaskCountKey) ?? 0}');

      print('╠══════════════════════════════════════════════════╣');
      print('║              APP STATISTICS                       ║');
      print('╠══════════════════════════════════════════════════╣');
      print('App Launch Count: ${prefs.getInt(_appLaunchCountKey) ?? 0}');
      print('First Launch: ${prefs.getBool(_isFirstLaunchKey) ?? true}');
      print('Last App Open: ${prefs.getString(_lastAppOpenKey) ?? 'NOT SET'}');
      print('Device ID: ${prefs.getString(_deviceIdKey) ?? 'NOT SET'}');

      print('╚══════════════════════════════════════════════════╝\n');

    } catch (e) {
      print('Error printing data: $e');
    }
  }
}
