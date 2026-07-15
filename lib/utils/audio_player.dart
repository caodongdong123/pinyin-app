import 'package:audioplayers/audioplayers.dart';

final AudioPlayer _audioPlayer = AudioPlayer();

void playAudio(String path) async {
  try {
    String assetPath = path;
    if (assetPath.startsWith('assets/')) {
      assetPath = assetPath.substring(7);
    }
    await _audioPlayer.play(AssetSource(assetPath));
  } catch (e) {
    print('Error playing audio: $e');
  }
}
