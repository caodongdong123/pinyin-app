import 'package:flutter/material.dart';
import '../utils/audio_player.dart';
import '../data/spelling_data.dart';

class SpellingPracticePage extends StatefulWidget {
  const SpellingPracticePage({super.key});

  @override
  State<SpellingPracticePage> createState() => _SpellingPracticePageState();
}

class _SpellingPracticePageState extends State<SpellingPracticePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  late List<Map<String, String>> _levels;
  int _currentIndex = 0;
  bool isCombined = false;

  @override
  void initState() {
    super.initState();
    _levels = SpellingData.generateExtendedLevels();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    
    // Animate from apart to together
    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _combinePinyin() {
    setState(() {
      isCombined = true;
    });
    _controller.forward();
    // Play combined audio
    playAudio(_levels[_currentIndex]['word'] ?? '');
  }

  void _resetOrNext() {
    if (isCombined) {
      if (_currentIndex < _levels.length - 1) {
        setState(() {
          _currentIndex++;
          isCombined = false;
        });
        _controller.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('太棒了！你完成了所有练习！')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentData = _levels[_currentIndex];
    final bool isThreePinyin = currentData.containsKey('final2');
    final Color themeColor = Colors.blue.shade400;

    return Scaffold(
      appBar: AppBar(
        title: const Text('拼读训练', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: themeColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '第 ${_currentIndex + 1} / ${_levels.length} 关',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blue.shade700
                ),
              ),
            ),
            
            Expanded(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    // Slide values based on animation and screen width to prevent cutoff
                    double maxDistance = MediaQuery.of(context).size.width * 0.18;
                    double distance = maxDistance * (1 - _slideAnimation.value);
                    double opacity = isCombined ? _slideAnimation.value : 0;
                    
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // The combining blocks
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Transform.translate(
                                offset: Offset(-distance, 0),
                                child: _buildPinyinCard(currentData['initial']!, Colors.blue),
                              ),
                              if (isThreePinyin) ...[
                                const SizedBox(width: 10),
                                _buildPinyinCard(currentData['final']!, Colors.green),
                              ],
                              const SizedBox(width: 10),
                              Transform.translate(
                                offset: Offset(distance, 0),
                                child: _buildPinyinCard(isThreePinyin ? currentData['final2']! : currentData['final']!, Colors.red),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 50),
                        
                        // The result
                        Opacity(
                          opacity: opacity,
                          child: Transform.scale(
                            scale: 0.5 + (0.5 * _slideAnimation.value),
                            child: Column(
                              children: [
                                Text(
                                  currentData['pinyin_full']!,
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    color: themeColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentData['word']!,
                                  style: TextStyle(
                                    fontSize: 60,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
            
            // Action Button
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: GestureDetector(
                onTap: isCombined ? _resetOrNext : _combinePinyin,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    color: isCombined ? Colors.orange.shade400 : themeColor,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: (isCombined ? Colors.orange : themeColor).withOpacity(0.5),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      isCombined ? '下一关' : '点击拼读',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinyinCard(String text, Color color) {
    return Container(
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 3),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}
