import 'package:flutter/material.dart';
import '../utils/audio_player.dart';

class PinyinLearningPage extends StatefulWidget {
  final String title;
  final List<Map<String, String>> dataList;
  final Color themeColor;

  const PinyinLearningPage({
    super.key,
    required this.title,
    required this.dataList,
    required this.themeColor,
  });

  @override
  State<PinyinLearningPage> createState() => _PinyinLearningPageState();
}

class _PinyinLearningPageState extends State<PinyinLearningPage> {
  int currentIndex = 0;
  bool _isAutoPlaying = false;

  void _nextPinyin() {
    if (currentIndex < widget.dataList.length - 1) {
      setState(() {
        currentIndex++;
        _isAutoPlaying = false; // Stop autoplay if user manually interacts
      });
      _playAudio();
    }
  }

  void _prevPinyin() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _isAutoPlaying = false;
      });
      _playAudio();
    }
  }

  void _playAudio() {
    // Play actual audio via web API
    playAudio(widget.dataList[currentIndex]['word'] ?? '');
  }

  void _toggleAutoPlay() async {
    if (_isAutoPlaying) {
      setState(() {
        _isAutoPlaying = false;
      });
      return;
    }

    setState(() {
      currentIndex = 0;
      _isAutoPlaying = true;
    });

    while (_isAutoPlaying && currentIndex < widget.dataList.length) {
      _playAudio();
      // Wait for audio to finish + some pause before next
      await Future.delayed(const Duration(milliseconds: 1500));
      if (!mounted || !_isAutoPlaying) break;
      
      if (currentIndex < widget.dataList.length - 1) {
        setState(() {
          currentIndex++;
        });
      } else {
        setState(() {
          _isAutoPlaying = false;
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Play audio for the first item on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentData = widget.dataList[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: widget.themeColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton.icon(
            onPressed: _toggleAutoPlay,
            icon: Icon(
              _isAutoPlaying ? Icons.stop_circle_rounded : Icons.play_circle_fill_rounded,
              color: Colors.white,
            ),
            label: Text(
              _isAutoPlaying ? '停止连播' : '连起来读',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: widget.themeColor.withOpacity(0.1),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    '${currentIndex + 1} / ${widget.dataList.length}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.themeColor,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: (currentIndex + 1) / widget.dataList.length,
                      backgroundColor: Colors.white,
                      color: widget.themeColor,
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: widget.themeColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Artistic Pinyin Letter Display
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [widget.themeColor, widget.themeColor.withOpacity(0.5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          currentData['pinyin']!,
                          style: const TextStyle(
                            fontSize: 150,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.0,
                            shadows: [
                              Shadow(
                                color: Colors.black26,
                                offset: Offset(4, 4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Description / Mnemonic
                      if (currentData.containsKey('desc'))
                        Text(
                          currentData['desc']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Bottom Controls
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Previous Button
                  _buildNavButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    color: currentIndex > 0 ? widget.themeColor : Colors.grey.shade300,
                    onTap: currentIndex > 0 ? _prevPinyin : null,
                  ),
                  
                  // Play Button
                  GestureDetector(
                    onTap: _playAudio,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: widget.themeColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.themeColor.withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.volume_up_rounded, size: 50, color: Colors.white),
                    ),
                  ),
                  
                  // Next Button
                  _buildNavButton(
                    icon: Icons.arrow_forward_ios_rounded,
                    color: currentIndex < widget.dataList.length - 1 ? widget.themeColor : Colors.grey.shade300,
                    onTap: currentIndex < widget.dataList.length - 1 ? _nextPinyin : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 36, color: color),
      ),
    );
  }
}
