import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/audio_player.dart';

class MatchingGamePage extends StatefulWidget {
  const MatchingGamePage({super.key});

  @override
  State<MatchingGamePage> createState() => _MatchingGamePageState();
}

class _MatchingGamePageState extends State<MatchingGamePage> {
  // Simple match game: match initial + final
  final Map<String, String> _matches = {
    'b': 'a',
    'p': 'o',
    'm': 'e',
    'f': 'u',
  };

  late List<String> _initials;
  late List<String> _finals;
  final Map<String, bool> _matchedStatus = {};

  int _score = 0;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    _initials = _matches.keys.toList()..shuffle();
    _finals = _matches.values.toList()..shuffle();
    for (var key in _initials) {
      _matchedStatus[key] = false;
    }
    _score = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('趣味连连看', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.pink.shade300,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.pink.shade50,
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
                      color: Colors.pink.shade400,
                    ),
                  ),
                  if (_score == _matches.length)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _initGame();
                        });
                      },
                      child: const Text('再玩一次', style: TextStyle(fontSize: 20)),
                    )
                ],
              ),
            ),
            
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Left column (Draggable Initials)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _initials.map((initChar) {
                      bool isMatched = _matchedStatus[initChar] == true;
                      return Draggable<String>(
                        data: initChar,
                        childWhenDragging: Opacity(
                          opacity: 0.3,
                          child: _buildTile(initChar, Colors.blue),
                        ),
                        feedback: Transform.scale(
                          scale: 1.1,
                          child: Material(
                            color: Colors.transparent,
                            child: _buildTile(initChar, Colors.blue),
                          ),
                        ),
                        child: isMatched
                            ? const SizedBox(width: 80, height: 80)
                            : _buildTile(initChar, Colors.blue),
                      );
                    }).toList(),
                  ),
                  
                  // Right column (DragTargets Finals)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _finals.map((finalChar) {
                      // find if this final is matched
                      String correspondingInitial = _matches.keys.firstWhere((k) => _matches[k] == finalChar);
                      bool isMatched = _matchedStatus[correspondingInitial] == true;
                      
                      return isMatched
                          ? _buildTile('$correspondingInitial$finalChar', Colors.orange)
                          : DragTarget<String>(
                              builder: (context, candidateData, rejectedData) {
                                return _buildTile(finalChar, Colors.green);
                              },
                              onWillAcceptWithDetails: (details) {
                                return _matches[details.data] == finalChar;
                              },
                              onAcceptWithDetails: (details) {
                                setState(() {
                                  _matchedStatus[details.data] = true;
                                  _score++;
                                });
                                // Play celebration audio
                                playAudio('太棒了，答对了！');
                              },
                            );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(String text, Color color) {
    return Container(
      width: 90,
      height: 90,
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
