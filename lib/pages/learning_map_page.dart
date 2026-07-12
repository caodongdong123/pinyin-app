import 'package:flutter/material.dart';
import '../data/pinyin_data.dart';
import 'pinyin_learning_page.dart';

class LearningMapPage extends StatelessWidget {
  const LearningMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础拼音认知', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.green.shade400,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.yellow.shade50,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionCard(
            context,
            title: '单韵母 (6个)',
            description: 'a o e i u ü',
            color: Colors.red.shade300,
            icon: Icons.face_retouching_natural,
            dataList: PinyinData.singleFinals,
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title: '声母 (23个)',
            description: 'b p m f d t n l...',
            color: Colors.blue.shade300,
            icon: Icons.record_voice_over,
            dataList: PinyinData.initials,
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title: '复韵母与鼻韵母 (18个)',
            description: 'ai ei ui ao ou iu...',
            color: Colors.purple.shade300,
            icon: Icons.library_music,
            dataList: PinyinData.compoundFinals,
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title: '整体认读音节 (16个)',
            description: 'zhi chi shi ri zi ci si...',
            color: Colors.orange.shade300,
            icon: Icons.all_inclusive,
            dataList: PinyinData.overallSyllables,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required List<Map<String, String>> dataList,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PinyinLearningPage(
              title: title,
              dataList: dataList,
              themeColor: color,
            ),
          ),
        );
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: color.withOpacity(0.5), width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 40, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
