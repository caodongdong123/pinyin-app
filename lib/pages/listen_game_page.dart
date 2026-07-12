import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/audio_player.dart';

class ListenGamePage extends StatefulWidget {
  const ListenGamePage({super.key});

  @override
  State<ListenGamePage> createState() => _ListenGamePageState();
}

class _ListenGamePageState extends State<ListenGamePage> {
  final List<String> pinyinList = ['a', 'o', 'e', 'b', 'p', 'm', 'f'];
  late String _targetPinyin;
  late List<String> _options;
  int _score = 0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _nextRound();
  }

  void _nextRound() {
    final random = Random();
    _targetPinyin = pinyinList[random.nextInt(pinyinList.length)];
    
    // Generate 4 unique options including the target
    Set<String> optSet = {_targetPinyin};
    while(optSet.length < 4) {
      optSet.add(pinyinList[random.nextInt(pinyinList.length)]);
    }
    _options = optSet.toList()..shuffle();
    
    // Auto play audio for new round
    _playAudio();
  }

  void _playAudio() {
    setState(() {
      _isPlaying = true;
    });
    // Play the placeholder audio
    playAudio('assets/audio/placeholder.mp3');
    
    // Simulate audio playing duration for animation
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _checkAnswer(String selected) {
    if (selected == _targetPinyin) {
      setState(() {
        _score += 10;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('太棒了，回答正确！'), duration: Duration(milliseconds: 500)),
      );
      Future.delayed(const Duration(milliseconds: 800), _nextRound);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('哎呀，听错啦，再试一次！'),
          backgroundColor: Colors.red.shade400,
          duration: const Duration(milliseconds: 800),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.green.shade400;

    return Scaffold(
      appBar: AppBar(
        title: const Text('听音辨形', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: themeColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.green.shade50,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '得分: $_score',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            // Audio Play Button
            GestureDetector(
              onTap: _playAudio,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.all(_isPlaying ? 40 : 35),
                decoration: BoxDecoration(
                  color: _isPlaying ? Colors.orange : themeColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: (_isPlaying ? Colors.orange : themeColor).withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  _isPlaying ? Icons.volume_up : Icons.play_arrow_rounded,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '点击喇叭，选出你听到的拼音',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade700),
            ),
            
            const Spacer(),
            
            // Options Grid
            Padding(
              padding: const EdgeInsets.all(30),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: _options.map((opt) => _buildOptionCard(opt, themeColor)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionCard(String text, Color color) {
    return GestureDetector(
      onTap: () => _checkAnswer(text),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: color.withOpacity(0.3), width: 3),
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
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
