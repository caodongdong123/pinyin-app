import 'dart:html' as html;

// Web implementation for playing audio
void playAudio(String path) {
  final audio = html.AudioElement(path);
  audio.play();
}
