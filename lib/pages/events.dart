import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    final List<Map<String, String>> events = [
      {
        'title': 'Hack the Future',
        'poster': 'assets/images/poster.jpg',
        'description':
        'Join our 24-hour hackathon to build futuristic solutions. Collaborate, innovate, and present your project to top judges from the tech industry.',
        'price': '₹199',
        'benefits': 'Swags, Mentorship, Networking',
        'prize': '₹15,000 Prize Pool'
      },
      {
        'title': 'Flutter Forge',
        'poster': 'assets/images/poster.jpg',
        'description':
        'A one-day Flutter development workshop where you’ll learn to build a beautiful app from scratch. Perfect for beginners who want to dive into app dev.',
        'price': 'Free',
        'benefits': 'Certification, Hands-on Coding',
        'prize': 'Goodies & Recognition'
      },
    ];

    return SingleChildScrollView(
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Our Exciting Events",
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: textColor,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Explore what we have in store for you — workshops, hackathons, and more!",
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: textColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 60),
            LayoutBuilder(builder: (context, constraints) {
              // Reduce card width by ~10%
              double cardWidth = constraints.maxWidth > 1200
                  ? ((constraints.maxWidth - 60) / 2) * 0.9
                  : constraints.maxWidth * 0.9;

              return Wrap(
                spacing: 40,
                runSpacing: 40,
                alignment: WrapAlignment.center,
                children: events.map((event) {
                  return AnimatedEventCard(
                    event: event,
                    isDarkMode: isDarkMode,
                    cardWidth: cardWidth,
                  );
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class AnimatedEventCard extends StatefulWidget {
  final Map<String, String> event;
  final bool isDarkMode;
  final double cardWidth;

  const AnimatedEventCard({
    super.key,
    required this.event,
    required this.isDarkMode,
    required this.cardWidth,
  });

  @override
  State<AnimatedEventCard> createState() => _AnimatedEventCardState();
}

class _AnimatedEventCardState extends State<AnimatedEventCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _visibleOnce = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(bool visible) {
    if (!_visibleOnce && visible) {
      _controller.forward();
      _visibleOnce = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = widget.isDarkMode ? Colors.white : Colors.black;
    final Color cardColor =
    widget.isDarkMode ? Colors.grey[900]! : Colors.grey[300]!;

    bool isMobile = widget.cardWidth < 800;
    double posterWidth = isMobile ? widget.cardWidth : widget.cardWidth * 0.4;
    double posterHeight = isMobile ? widget.cardWidth * 0.55 : widget.cardWidth * 0.35;

    return LayoutBuilder(builder: (context, constraints) {
      return TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 800),
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Transform.translate(
              offset: Offset(0, (1 - value) * 20),
              child: child,
            ),
          );
        },
        child: Container(
          width: widget.cardWidth,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: widget.isDarkMode ? Colors.white12 : Colors.black12),
            boxShadow: [
              BoxShadow(
                color: widget.isDarkMode
                    ? Colors.black45
                    : Colors.grey.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _poster(widget.event['poster']!, posterWidth, posterHeight),
              const SizedBox(height: 20),
              _eventContent(widget.event, textColor),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: posterWidth,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _poster(
                      widget.event['poster']!, posterWidth, posterHeight),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(child: _eventContent(widget.event, textColor)),
            ],
          ),
        ),
      );
    });
  }

  Widget _poster(String path, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        path,
        width: width,
        height: height,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _eventContent(Map<String, String> event, Color textColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          event['title']!,
          style: GoogleFonts.rajdhani(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          event['description']!,
          style: GoogleFonts.rajdhani(
            fontSize: 16,
            color: textColor.withOpacity(0.8),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Benefits & Prize Pool",
          style: GoogleFonts.rajdhani(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _pill(event['benefits']!, Colors.pink[200]!),
            _pill(event['prize']!, Colors.pink[200]!),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "Entry Fee: ${event['price']!}",
          style: GoogleFonts.rajdhani(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.pink[200],
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink[200],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          ),
          onPressed: () {},
          child: Text(
            "Register",
            style: GoogleFonts.rajdhani(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _pill(String text, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: GoogleFonts.rajdhani(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.pink[200],
        ),
      ),
    );
  }
}
