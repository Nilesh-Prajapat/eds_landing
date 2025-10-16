import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../fx_14_text_reveal/strategies/FadeBlurStrategy.dart';
import '../fx_14_text_reveal/text_reveal_widget.dart';
import '../theme/theme_provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with SingleTickerProviderStateMixin {
  bool _isVisible = false;

  late AnimationController _logoController;
  late Animation<double> _logoAnimation;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  void _triggerAnimations() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
      _logoController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isMobile = size.width < 1000;
    final logoWidth = isMobile ? size.width * 0.25 : size.width * 0.2;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 30),
      child: VisibilityDetector(
        key: const Key('about-us-visibility'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.1) _triggerAnimations();
        },
        child: Center(
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) => Opacity(
                  opacity: _logoAnimation.value,
                  child: child,
                ),
                child: Image.asset('assets/logo/logo.png', width: logoWidth),
              ),
              const SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.rajdhani(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                    letterSpacing: 1.2,
                  ),
                  children: [
                    const TextSpan(text: "About "),
                    TextSpan(
                      text: "EDS",
                      style: TextStyle(
                        color: Colors.pink[200], // highlight color
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: size.width * 0.85,
                child: EnhancedTextRevealEffect(
                  text:
                  "EDS, the tech innovation hub of CDGI, ignites creativity and collaboration. From Hackwave 2.0 to DevHack and beyond, we craft immersive hackathons where aspiring innovators converge, ideas flourish, and the future of technology is shaped. Join us in pushing boundaries and coding the extraordinary.",
                  strategy: FadeBlurStrategy(),
                  unit: AnimationUnit.word,
                  trigger: _isVisible,
                  style: GoogleFonts.rajdhani(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          )
              : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _logoAnimation,
                builder: (context, child) => Opacity(
                  opacity: _logoAnimation.value,
                  child: child,
                ),
                child: Image.asset('assets/logo/logo.png', width: logoWidth),
              ),
              const SizedBox(width: 80),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.orbitron(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                          letterSpacing: 1.2,
                        ),
                        children: [
                          const TextSpan(text: "About "),
                          TextSpan(
                            text: "EDS",
                            style: TextStyle(
                              color: Colors.pink[200], // Highlighted color
                              shadows: [

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: 500,
                      child: EnhancedTextRevealEffect(
                        text:
                        "EDS, the tech innovation hub of CDGI, ignites creativity and collaboration. From Hackwave 2.0 to DevHack and beyond, we craft immersive hackathons where aspiring innovators converge, ideas flourish, and the future of technology is shaped. Join us in pushing boundaries and coding the extraordinary.",
                        strategy: FadeBlurStrategy(),
                        unit: AnimationUnit.word,
                        trigger: _isVisible,
                        style: GoogleFonts.rajdhani(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: isDarkMode ? Colors.white70 : Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
