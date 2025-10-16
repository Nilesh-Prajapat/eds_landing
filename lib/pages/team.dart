import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/theme_provider.dart';

class TeamSection extends StatelessWidget {
  const TeamSection({super.key});

  final List<Map<String, String>> coreMembers = const [
    {"name": "Alice Smith", "department": "Technical"},
    {"name": "Bob Johnson", "department": "Operations"},
    {"name": "Catherine Lee", "department": "Outreach"},
    {"name": "David Kim", "department": "Social"},
    {"name": "Ethan Brown", "department": "Technical"},
    {"name": "Fiona Davis", "department": "Operations"},
    {"name": "George Wilson", "department": "Social"},
  ];

  final List<Map<String, String>> teamMembers = const [
    {"name": "Hannah Clark", "department": "Outreach"},
    {"name": "Ian Lewis", "department": "Operations"},
    {"name": "Julia Hall", "department": "Operations"},
    {"name": "Kevin Young", "department": "Operations"},
    {"name": "Grey Tech", "department": "Technical"},
    {"name": "Mason Lee", "department": "Outreach"},
    {"name": "Nora Adams", "department": "Social"},
    {"name": "Oscar Reed", "department": "Social"},
    {"name": "Paula White", "department": "Social"},
    {"name": "Quentin Black", "department": "Outreach"},
  ];

  Widget memberCard(Map<String, String> member, bool isDarkMode) {
    return _AnimatedCard(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: isDarkMode ? Colors.white : Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                "assets/logo/nilesh.png",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name']!,
                        style: GoogleFonts.rajdhani(
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          member['department']!,
                          style: GoogleFonts.rajdhani(
                            color: isDarkMode ? Colors.black : Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final url = Uri.parse('https://www.linkedin.com/in/Nilesh-Prajapat');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Image.asset(
                        "assets/icons/linkedin.png",
                        width: 28,
                        height: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final url = Uri.parse('https://www.instagram.com/nilesh__pr_');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                      child: Image.asset(
                        "assets/icons/instagram.png",
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget section(
      String heading,
      String subText,
      List<Map<String, String>> members,
      bool isDarkMode,
      ) {
    // Split heading to color specific words
    List<String> splitHeading = heading.split(" ");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.rajdhani(
                    fontSize: 38, // increased size
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  children: splitHeading.map((word) {
                    // Color specific words pink
                    Color wordColor = (word.toLowerCase() == 'core' || word.toLowerCase() == 'crew')
                        ? Colors.pink[200]!
                        : (isDarkMode ? Colors.white : Colors.black);
                    return TextSpan(text: "$word ", style: TextStyle(color: wordColor));
                  }).toList(),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subText,
                textAlign: TextAlign.center,
                style: GoogleFonts.rajdhani(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = (constraints.maxWidth ~/ 240).clamp(2, 5);
            double cardWidth = (constraints.maxWidth - (crossAxisCount - 1) * 24) / crossAxisCount;

            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 24,
              children: members
                  .map((member) => SizedBox(
                width: cardWidth,
                child: memberCard(member, isDarkMode),
              ))
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 32),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final double navbarHeight = 80;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: navbarHeight + 16, left: 16, right: 16, bottom: 32),
        child: Column(
          children: [
            section(
              "Meet Our Core Team",
              "The brilliant minds behind our projects, shaping ideas into reality",
              coreMembers,
              isDarkMode,
            ),
            section(
              "The Wider Crew",
              "Our extended family bringing energy, creativity, and support to every project",
              teamMembers,
              isDarkMode,
            ),

          ],
        ),
      ),
    );
  }
}

// Animated card that fades in when visible
class _AnimatedCard extends StatefulWidget {
  final Widget child;
  const _AnimatedCard({required this.child});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.child.hashCode.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0 && !_visible) {
          setState(() {
            _visible = true;
          });
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _visible ? 1 : 0,
        child: widget.child,
      ),
    );
  }
}
