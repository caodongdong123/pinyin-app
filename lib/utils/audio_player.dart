import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts _flutterTts = FlutterTts();
bool _isInitialized = false;

Future<void> _initTts() async {
  if (_isInitialized) return;
  await _flutterTts.setLanguage("zh-CN");
  await _flutterTts.setSpeechRate(0.5); // standard natural rate
  await _flutterTts.setVolume(1.0);
  await _flutterTts.setPitch(1.0); // natural voice, avoids robotic distortion
  _isInitialized = true;
}

// Pronunciation mapping for pinyin to Chinese characters
final Map<String, String> _pinyinMap = {
  // 声母
  'b': '波',
  'p': '坡',
  'm': '摸',
  'f': '佛',
  'd': '得',
  't': '特',
  'n': '呢',
  'l': '勒',
  'g': '哥',
  'k': '科',
  'h': '喝',
  'j': '鸡',
  'q': '七',
  'x': '西',
  'zh': '知',
  'ch': '吃',
  'sh': '师',
  'r': '日',
  'z': '资',
  'c': '刺',
  's': '丝',
  'y': '衣',
  'w': '屋',
  // 韵母
  'a': '阿',
  'o': '喔',
  'e': '鹅',
  'i': '衣',
  'u': '乌',
  'ü': '迂',
  'ai': '哀',
  'ei': '诶',
  'ui': '威',
  'ao': '熬',
  'ou': '欧',
  'iu': '优',
  'ie': '耶',
  'üe': '约',
  'er': '儿',
  'an': '安',
  'en': '恩',
  'in': '音',
  'un': '温',
  'ün': '晕',
  'ang': '昂',
  'eng': '鞥', 
  'ing': '英',
  'ong': '轰',
};

void playAudio(String text) async {
  try {
    await _initTts();
    
    // Check if the input is a single pinyin letter/string
    String textToRead = text.trim();
    if (_pinyinMap.containsKey(textToRead.toLowerCase())) {
      textToRead = _pinyinMap[textToRead.toLowerCase()]!;
    }
    
    // Fallback if an old asset path is accidentally passed
    if (textToRead.startsWith('assets/')) {
      textToRead = ''; 
    }
    
    if (textToRead.isNotEmpty) {
      await _flutterTts.speak(textToRead);
    }
  } catch (e) {
    print('Error playing TTS: $e');
  }
}
