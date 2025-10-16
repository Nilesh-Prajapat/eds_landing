import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' show launchUrl;
import '../theme/theme_provider.dart';

class HomePageSection extends StatefulWidget {
  const HomePageSection({super.key});

  @override
  State<HomePageSection> createState() => _HomePageSectionState();
}

class _HomePageSectionState extends State<HomePageSection>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color highlightYellow = Colors.amberAccent.shade200; // bright yellow
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    final size = MediaQuery.of(context).size;
    final bool isMobile = size.width < 800;

    final Color letterColor = isDarkMode ? Colors.white : Colors.black;
    final Color bgColor = isDarkMode ? Colors.black : Colors.white;


    final double headingFontSize = isMobile
        ? (size.width * 0.07).clamp(22, 36)
        : (size.width * 0.045).clamp(28, 60);
    final double edsFontSize = isMobile
        ? (size.width * 0.15).clamp(28, 50)
        : (size.width * 0.07).clamp(35, 90);

    final double spacingHeadingToEDS = isMobile ? 20 : 30;
    final double spacingEDSToRow = isMobile ? 18 : 28;
    final double edsWrapSpacing = isMobile ? 15 : 30;

    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [

          AnimatedOpacity(
            duration: const Duration(milliseconds: 1200),
            opacity: _visible ? 1 : 0,
            curve: Curves.easeOut,
            child: AnimatedSlide(
              offset: _visible ? Offset.zero : const Offset(0, 0.1),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOut,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome to The",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: headingFontSize,
                        fontWeight: FontWeight.bold,
                        color: letterColor,
                      ),
                    ),
                    SizedBox(height: spacingHeadingToEDS),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: edsWrapSpacing,
                      runSpacing: edsWrapSpacing / 2,
                      children: [
                        _edsText("E", "Echelon", Colors.pinkAccent.shade100, letterColor, edsFontSize),
                        _edsText("D", "Dev", Colors.purpleAccent.shade100, letterColor, edsFontSize, curly: true),
                        _edsText("S", "Society", Colors.lightBlueAccent.shade100, letterColor, edsFontSize),
                      ],
                    ),
                    SizedBox(height: spacingEDSToRow),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "A Perfect place for {",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: headingFontSize * 0.6,
                            fontWeight: FontWeight.bold,
                            color: letterColor,
                          ),
                        ),
                        DefaultTextStyle(
                          style: GoogleFonts.playfairDisplay(
                            fontSize: headingFontSize * 0.7,
                            fontWeight: FontWeight.bold,
                            color: highlightYellow,
                          ),
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText("Developers",
                                  speed: const Duration(milliseconds: 100)),
                              TypewriterAnimatedText("Innovators",
                                  speed: const Duration(milliseconds: 100)),
                              TypewriterAnimatedText("Creators",
                                  speed: const Duration(milliseconds: 100)),
                            ],
                            repeatForever: true,
                            pause: const Duration(milliseconds: 800),
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true,
                          ),
                        ),
                        Text(
                          "}",
                          style: GoogleFonts.playfairDisplay(
                            fontSize: headingFontSize * 0.6,
                            fontWeight: FontWeight.bold,
                            color: letterColor,
                          ),
                        ),
                      ],
                    ),
// Join the Community section
                    SizedBox(height: spacingEDSToRow),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse("https://discord.gg/3ZBF6AQtW")); // replace with your URL
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Join the Community",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: headingFontSize * 0.5,
                                  fontWeight: FontWeight.bold,

                                  color: letterColor, // automatically changes with theme
                                ),
                              ),
                              SizedBox(width: 8),
                              Image.asset(
                                'assets/icons/arrow.png',
                                width: headingFontSize * 0.5,
                                height: headingFontSize * 0.5,

                                color: letterColor, // recolors arrow according to dark/light mode
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isMobile ? 16 : 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _socialIcon(assetPath: 'assets/icons/instagram.png', url: 'https://www.instagram.com/nilesh__pr_/', size: isMobile ? 28 : 32),
                            SizedBox(width: isMobile ? 20 : 28),
                            _socialIcon(assetPath: 'assets/icons/whatsapp.png', url: 'https://wa.me/9340236043', size: isMobile ? 28 : 32),
                            SizedBox(width: isMobile ? 20 : 28),
                            _socialIcon(assetPath: 'assets/icons/linkedin.png', url: 'https://linkedin.com/in/nilesh-prajapat', size: isMobile ? 28 : 32),
                            SizedBox(width: isMobile ? 20 : 28),
                            _socialIcon(assetPath: 'assets/icons/discord.png', url: 'https://discord.gg/3ZBF6AQtW', size: isMobile ? 28 : 32),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _socialIcon({required String assetPath, required String url, double size = 28}) {
    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
      ),
    );
  }


  Widget _edsText(String letter, String word, Color color, Color letterColor,
      double fontSize,
      {bool curly = false}) {
    final Color highlightYellow = Colors.amberAccent.shade200; // bright yellow

    return RichText(
      text: TextSpan(
        style: GoogleFonts.playfairDisplay(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
        children: [
          TextSpan(text: letter, style: TextStyle(color: letterColor)),
          TextSpan(text: ":", style: TextStyle(color:highlightYellow)),
          if (curly)
            TextSpan(text: " {", style: TextStyle(color: highlightYellow)),
          TextSpan(text: word, style: TextStyle(color: color)),
          if (curly)
            TextSpan(text: "}", style: TextStyle(color: highlightYellow)),
        ],
      ),
    );
  }
}

