
import 'package:flutter/material.dart';
import 'package:sssmobileapp/utils/local_storage/shared_pref.dart';
import 'package:sssmobileapp/view/auth/signin.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String? selectedLanguageCode;
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇦🇺'},
    {'code': 'es', 'name': 'Spanish', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'French', 'flag': '🇫🇷'},
  ];

  late List<Map<String, String>> _filteredLanguages;

  @override
  void initState() {
    super.initState();
    _filteredLanguages = List.from(_languages);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _filteredLanguages = _languages.where((lang) {
        return lang['name']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _onLanguageSelected(String code) async {
    setState(() => selectedLanguageCode = code);

    await SharedPrefs.setLanguageCode(code);
    await SharedPrefs.setLanguageSelected();

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (_) => const SignIn()),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFF9800),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
          size: 24,
        ),
        title: const Text(
          'Select Language',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Space for status bar + appbar
          const SizedBox(height: 100),

          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search field - icon on RIGHT
                    TextField(
                      controller: _searchController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: 'Search Language',
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 16,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.search_rounded,
                            color: Color(0xff8D8D8D),
                            size: 26,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey.shade100),
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // Title with exact line break
                    const Text(
                      'What is your\nlanguage?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1.18,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 28),

                    ..._filteredLanguages.map((lang) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => _onLanguageSelected(lang['code']!),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    lang['flag']!,
                                    style: const TextStyle(fontSize: 36),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      lang['name']!,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Divider starts after flag + spacing (≈56px)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xffCACACA),
                            indent: 56,
                            endIndent: 24,
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
