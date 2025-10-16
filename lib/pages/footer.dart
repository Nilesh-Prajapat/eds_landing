import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this
import '../theme/theme_provider.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    final size = MediaQuery.of(context).size;
    final width = size.width;

    final bool isMobile = width < 800;
    final bool isTablet = width >= 800 && width < 1200;

    final double logoSize = isMobile ? 50 : isTablet ? 55 : 60;
    final double titleFontSize = isMobile ? 24 : isTablet ? 28 : 32;
    final double quoteFontSize = isMobile ? 14 : 16;
    final double funLineFontSize = isMobile ? 12 : 14;
    final double socialIconSize = isMobile ? 20 : 24;
    final double arrowSize = isMobile ? 12 : 16;

    return Container(
      width: width,
      color: isDarkMode ? Colors.black87 : Colors.white,
      child: Column(
        children: [
          Divider(
            color: isDarkMode ? Colors.white30 : Colors.black26,
            thickness: 1.2,
          ),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                vertical: isMobile ? 30 : 50, horizontal: isMobile ? 20 : 40),
            child: isMobile || isTablet
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _brandingSection(isDarkMode, logoSize, titleFontSize,
                    quoteFontSize, funLineFontSize),
                const SizedBox(height: 30),
                _socialLinksSection(
                    isDarkMode, isMobile, socialIconSize, arrowSize),
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: _brandingSection(isDarkMode, logoSize,
                      titleFontSize, quoteFontSize, funLineFontSize),
                ),
                const SizedBox(width: 40),
                Flexible(
                  flex: 1,
                  child: _socialLinksSection(
                      isDarkMode, isMobile, socialIconSize, arrowSize),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Divider(color: isDarkMode ? Colors.white24 : Colors.black26),
          const SizedBox(height: 12),
          Center(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "© 2025 Echelon Dev Society. All rights reserved.  ",
                    style: GoogleFonts.rajdhani(
                      fontSize: isMobile ? 12 : 14,
                      color: isDarkMode ? Colors.white60 : Colors.black54,
                    ),
                  ),
                  TextSpan(
                    text: "Designed by Nilesh",
                    style: GoogleFonts.rajdhani(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16), // Extra spacing for personal branding
        ],
      ),
    );
  }

  Widget _brandingSection(bool isDarkMode, double logoSize, double titleFontSize,
      double quoteFontSize, double funLineFontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              "assets/logo/logo.png",
              height: logoSize,
              width: logoSize,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            RichText(
              text: TextSpan(
                style: GoogleFonts.rajdhani(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                      text: "Echelon ",
                      style: TextStyle(color: Colors.pink[200])),
                  TextSpan(
                      text: "Dev ", style: TextStyle(color: Colors.blue[200])),
                  TextSpan(
                      text: "Society",
                      style: TextStyle(color: Colors.purple[200])),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Empowering Developers. Innovating Futures.",
          style: GoogleFonts.rajdhani(
            fontSize: quoteFontSize,
            color: (isDarkMode ? Colors.white : Colors.black).withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Sumit Bhaiya knows me… yet here I am, being poked with an EDS task! 😅",
          style: GoogleFonts.rajdhani(
            fontSize: funLineFontSize,
            color: (isDarkMode ? Colors.white70 : Colors.black87).withOpacity(0.7),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
  Widget _socialLinksSection(
      bool isDarkMode, bool isMobile, double socialIconSize, double arrowSize) {
    final List<Map<String, String>> links = [
      {
        "label": "Email",
        "icon": "assets/icons/gmail.png",
        "arrow": "assets/icons/arrow.png",
        "url": "mailto:work.nilesh.pr@gmail.com"
      },
      {
        "label": "Discord",
        "icon": "assets/icons/discord.png",
        "arrow": "assets/icons/arrow.png",
        "url": "https://discord.com/users/3ZBF6AQtW"
      },
      {
        "label": "Instagram",
        "icon": "assets/icons/instagram.png",
        "arrow": "assets/icons/arrow.png",
        "url": "https://instagram.com/nilesh__pr_"
      },
      {
        "label": "LinkedIn",
        "icon": "assets/icons/linkedin.png",
        "arrow": "assets/icons/arrow.png",
        "url": "https://www.linkedin.com/in/Nilesh-Prajapat"
      },
    ];

    final Color arrowColor = isDarkMode ? Colors.white : Colors.black;

    return Wrap(
      spacing: 30,
      runSpacing: 20,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: links.map((link) {
        return InkWell(
          onTap: () async {
            final Uri url = Uri.parse(link["url"]!);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch ${link["url"]}';
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                link["icon"]!,
                height: socialIconSize,
                width: socialIconSize,
              ),
              const SizedBox(width: 8),
              Text(
                link["label"]!,
                style: GoogleFonts.rajdhani(
                  fontSize: socialIconSize * 0.65,
                  fontWeight: FontWeight.w600,
                  color: Colors.pink[200],
                ),
              ),
              const SizedBox(width: 4),
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    arrowColor, BlendMode.srcIn), // changes arrow color
                child: Image.asset(
                  link["arrow"]!,
                  height: arrowSize,
                  width: arrowSize,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

}
