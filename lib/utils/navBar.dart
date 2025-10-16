import 'dart:ui';
import 'package:eds_landing/pages/aboutUs.dart';
import 'package:eds_landing/pages/contactUs.dart';
import 'package:eds_landing/pages/events.dart';
import 'package:eds_landing/pages/team.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/homePage.dart';
import '../theme/theme_provider.dart';
import 'grid.dart';

class GlassyNavPage extends StatefulWidget {
  const GlassyNavPage({super.key});

  @override
  State<GlassyNavPage> createState() => _GlassyNavPageState();
}
class _GlassyNavPageState extends State<GlassyNavPage> {
  final List<String> navItems = ['Home', 'About Us', 'Team', 'Events', 'Contact Us'];
  final Map<String, GlobalKey> sectionKeys = {
    'home': GlobalKey(),
    'aboutus': GlobalKey(),
    'team': GlobalKey(),
    'events': GlobalKey(),
    'contactus': GlobalKey(),
  };
  final ScrollController _scrollController = ScrollController();
  late final Map<String, Widget> sectionPages;

  String activeSection = 'home';
  bool showDropdown = false;

  // Use ValueNotifier to reduce rebuilds
  final ValueNotifier<String> activeSectionNotifier = ValueNotifier('home');

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    sectionPages = {
      'home': const HomePageSection(),
      'aboutus': const AboutUs(),
      'team': const TeamSection(),
      'events': const events(),
      'contactus': const contactUs(),
    };

    // Pre-cache images
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage("assets/logo/logo.png"), context);
    });
  }

  void _onScroll() {
    // Only update ValueNotifier when section changes
    for (var entry in sectionKeys.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero).dy;
        if (pos < 150 && pos > -400 && activeSectionNotifier.value != entry.key) {
          activeSectionNotifier.value = entry.key;
          break;
        }
      }
    }
  }

  void scrollToSection(String key) {
    final context = sectionKeys[key]?.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      activeSectionNotifier.value = key;
    }
    setState(() => showDropdown = false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    activeSectionNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final bool isDark = themeProvider.isDarkMode;
    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 1000;

    final double navbarHeight = 70;
    final double navBarWidth = isMobile
        ? size.width * 0.9
        : (size.width * 0.7).clamp(300, 1200);
    final Color gridLineColor =
    isDark ? Colors.grey.withOpacity(0.15) : Colors.grey.withOpacity(0.25);

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: GridBackgroundPainter(lineColor: gridLineColor),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: navItems.map((item) {
                final key = item.toLowerCase().replaceAll(' ', '');
                // Wrap sections with RepaintBoundary to reduce repaint cost
                return RepaintBoundary(
                  key: sectionKeys[key],
                  child: sectionPages[key]!,
                );
              }).toList(),
            ),
          ),

          // NAVBAR
          Positioned(
            top: 24,
            left: (size.width - navBarWidth) / 2,
            width: navBarWidth,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  height: navbarHeight,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: isDark ? Colors.white70 : Colors.black,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => scrollToSection('home'),
                        child: Center(
                          child: Image.asset(
                            "assets/logo/logo.png",
                            height: isMobile ? 40 : 50,
                            width: isMobile ? 40 : 50,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      if (!isMobile)
                        Expanded(
                          child: ValueListenableBuilder<String>(
                            valueListenable: activeSectionNotifier,
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: navItems.map((item) {
                                  final key = item.toLowerCase().replaceAll(' ', '');
                                  final isActive = value == key;
                                  return GestureDetector(
                                    onTap: () => scrollToSection(key),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250),
                                      margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: isActive
                                            ? (isDark ? Colors.white12 : Colors.black12)
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(25),
                                        border: isActive
                                            ? Border.all(
                                          color: isDark
                                              ? Colors.white70
                                              : Colors.black87,
                                          width: 1.5,
                                        )
                                            : Border.all(color: Colors.transparent),
                                      ),
                                      child: Text(
                                        item,
                                        style: TextStyle(
                                          color: isActive
                                              ? (isDark
                                              ? const Color(0xFF40C4FF)
                                              : const Color(0xFFFFB300))
                                              : (isDark ? Colors.white70 : Colors.black87),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      Row(
                        children: [
                          _buildThemeToggleButton(themeProvider),
                          if (isMobile)
                            IconButton(
                              icon: Icon(
                                showDropdown ? Icons.close : Icons.menu,
                                color: isDark ? Colors.white : Colors.black,
                              ),
                              onPressed: () =>
                                  setState(() => showDropdown = !showDropdown),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // MOBILE DROPDOWN
          if (isMobile && showDropdown)
            Positioned(
              top: navbarHeight + 24,
              left: (size.width - navBarWidth) / 2,
              width: navBarWidth,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  color: isDark
                      ? Colors.grey[900]?.withOpacity(0.95)
                      : Colors.white.withOpacity(0.95),
                  child: Column(
                    children: navItems.map((item) {
                      final key = item.toLowerCase().replaceAll(' ', '');
                      final isActive = activeSectionNotifier.value == key;
                      return ListTile(
                        title: Text(
                          item,
                          style: TextStyle(
                            color: isActive
                                ? Colors.yellow.shade400
                                : (isDark ? Colors.white70 : Colors.black87),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => scrollToSection(key),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

  Widget _buildThemeToggleButton(ThemeProvider themeProvider) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return RotationTransition(
          turns: Tween<double>(begin: 0.5, end: 1).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: IconButton(
        key: ValueKey<bool>(themeProvider.isDarkMode),
        icon: Icon(
          themeProvider.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
          color: themeProvider.isDarkMode ? Color(0xFF40C4FF) : Color(0xFFFFB300),
          size: 28,
        ),
        onPressed: themeProvider.toggleTheme,
      ),
    );
  }

