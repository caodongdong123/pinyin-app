class PinyinData {
  // 单韵母 (6个)
  static const List<Map<String, String>> singleFinals = [
    {'pinyin': 'a', 'audio': 'a.mp3', 'image': 'apple.png', 'desc': '张大嘴巴 a a a'},
    {'pinyin': 'o', 'audio': 'o.mp3', 'image': 'rooster.png', 'desc': '圆圆嘴巴 o o o'},
    {'pinyin': 'e', 'audio': 'e.mp3', 'image': 'goose.png', 'desc': '扁扁嘴巴 e e e'},
    {'pinyin': 'i', 'audio': 'i.mp3', 'image': 'clothes.png', 'desc': '牙齿对齐 i i i'},
    {'pinyin': 'u', 'audio': 'u.mp3', 'image': 'turtle.png', 'desc': '嘴巴突出 u u u'},
    {'pinyin': 'ü', 'audio': 'v.mp3', 'image': 'fish.png', 'desc': '嘴吹口哨 ü ü ü'},
  ];

  // 复韵母与鼻韵母 (18个)
  static const List<Map<String, String>> compoundFinals = [
    {'pinyin': 'ai', 'audio': 'ai.mp3'},
    {'pinyin': 'ei', 'audio': 'ei.mp3'},
    {'pinyin': 'ui', 'audio': 'ui.mp3'},
    {'pinyin': 'ao', 'audio': 'ao.mp3'},
    {'pinyin': 'ou', 'audio': 'ou.mp3'},
    {'pinyin': 'iu', 'audio': 'iu.mp3'},
    {'pinyin': 'ie', 'audio': 'ie.mp3'},
    {'pinyin': 'üe', 'audio': 've.mp3'},
    {'pinyin': 'er', 'audio': 'er.mp3'},
    {'pinyin': 'an', 'audio': 'an.mp3'},
    {'pinyin': 'en', 'audio': 'en.mp3'},
    {'pinyin': 'in', 'audio': 'in.mp3'},
    {'pinyin': 'un', 'audio': 'un.mp3'},
    {'pinyin': 'ün', 'audio': 'vn.mp3'},
    {'pinyin': 'ang', 'audio': 'ang.mp3'},
    {'pinyin': 'eng', 'audio': 'eng.mp3'},
    {'pinyin': 'ing', 'audio': 'ing.mp3'},
    {'pinyin': 'ong', 'audio': 'ong.mp3'},
  ];

  // 声母 (23个)
  static const List<Map<String, String>> initials = [
    {'pinyin': 'b', 'audio': 'b.mp3', 'image': 'radio.png', 'desc': '像个6字 b b b'},
    {'pinyin': 'p', 'audio': 'p.mp3', 'image': 'water.png', 'desc': '脸盆泼水 p p p'},
    {'pinyin': 'm', 'audio': 'm.mp3', 'image': 'door.png', 'desc': '两个门洞 m m m'},
    {'pinyin': 'f', 'audio': 'f.mp3', 'image': 'buddha.png', 'desc': '一根拐棍 f f f'},
    {'pinyin': 'd', 'audio': 'd.mp3', 'image': 'drum.png', 'desc': '左下半圆 d d d'},
    {'pinyin': 't', 'audio': 't.mp3', 'image': 'umbrella.png', 'desc': '伞柄朝下 t t t'},
    {'pinyin': 'n', 'audio': 'n.mp3', 'image': 'door1.png', 'desc': '一个门洞 n n n'},
    {'pinyin': 'l', 'audio': 'l.mp3', 'image': 'stick.png', 'desc': '一根小棍 l l l'},
    {'pinyin': 'g', 'audio': 'g.mp3', 'image': 'pigeon.png', 'desc': '9字加弯 g g g'},
    {'pinyin': 'k', 'audio': 'k.mp3', 'image': 'tadpole.png', 'desc': '两只蝌蚪 k k k'},
    {'pinyin': 'h', 'audio': 'h.mp3', 'image': 'chair.png', 'desc': '一把椅子 h h h'},
    {'pinyin': 'j', 'audio': 'j.mp3', 'image': 'chicken.png', 'desc': '小鸡啄米 j j j'},
    {'pinyin': 'q', 'audio': 'q.mp3', 'image': 'balloon.png', 'desc': '左上半圆 q q q'},
    {'pinyin': 'x', 'audio': 'x.mp3', 'image': 'watermelon.png', 'desc': '刀切西瓜 x x x'},
    {'pinyin': 'zh', 'audio': 'zh.mp3', 'image': 'spider.png', 'desc': '蜘蛛结网 zh zh zh'},
    {'pinyin': 'ch', 'audio': 'ch.mp3', 'image': 'ruler.png', 'desc': '皮尺卷起 ch ch ch'},
    {'pinyin': 'sh', 'audio': 'sh.mp3', 'image': 'lion.png', 'desc': '森林狮子 sh sh sh'},
    {'pinyin': 'r', 'audio': 'r.mp3', 'image': 'sun.png', 'desc': '红日当空 r r r'},
    {'pinyin': 'z', 'audio': 'z.mp3', 'image': 'duck.png', 'desc': '像个2字 z z z'},
    {'pinyin': 'c', 'audio': 'c.mp3', 'image': 'hedgehog.png', 'desc': '半个圆圈 c c c'},
    {'pinyin': 's', 'audio': 's.mp3', 'image': 'silkworm.png', 'desc': '半个8字 s s s'},
    {'pinyin': 'y', 'audio': 'y.mp3', 'image': 'clothes.png', 'desc': '树杈 y y y'},
    {'pinyin': 'w', 'audio': 'w.mp3', 'image': 'house.png', 'desc': '屋顶 w w w'},
  ];

  // 整体认读音节 (16个)
  static const List<Map<String, String>> overallSyllables = [
    {'pinyin': 'zhi', 'audio': 'zhi.mp3'},
    {'pinyin': 'chi', 'audio': 'chi.mp3'},
    {'pinyin': 'shi', 'audio': 'shi.mp3'},
    {'pinyin': 'ri', 'audio': 'ri.mp3'},
    {'pinyin': 'zi', 'audio': 'zi.mp3'},
    {'pinyin': 'ci', 'audio': 'ci.mp3'},
    {'pinyin': 'si', 'audio': 'si.mp3'},
    {'pinyin': 'yi', 'audio': 'yi.mp3'},
    {'pinyin': 'wu', 'audio': 'wu.mp3'},
    {'pinyin': 'yu', 'audio': 'yu.mp3'},
    {'pinyin': 'ye', 'audio': 'ye.mp3'},
    {'pinyin': 'yue', 'audio': 'yue.mp3'},
    {'pinyin': 'yuan', 'audio': 'yuan.mp3'},
    {'pinyin': 'yin', 'audio': 'yin.mp3'},
    {'pinyin': 'yun', 'audio': 'yun.mp3'},
    {'pinyin': 'ying', 'audio': 'ying.mp3'},
  ];
}
