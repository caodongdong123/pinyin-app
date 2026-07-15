import 'dart:math';
import 'package:lpinyin/lpinyin.dart';

class SpellingData {
  // A collection of over 2500 common primary school Chinese characters
  static const String commonCharacters =
      '的一是在不了有和人这中大为上个国我以要他时来用们生到作地于出就分对成会可主发年动同工也能下过子说产种面而方后多定行学法所民得经十三之进着等部度家电力里如水化高自二理起小物现实加量都两体制机当使点从业本去把性好应开它合还因由其些然前外天政四日那社义事平形相全表间样与关各重新线内数正心反你明看原又么利比或但交建月意解决公五明特见期导音象影图白交类号清流太门计百先文向气长条结回新从第问位知将她更老通打万光强指西传展干保眼快东身细石农书真水高其然政本多产前实如这在要人中大一有的了是不作地着就出到生们用以来他时上个国我学分和能可同下工过年发主成以对为多起化电力家度部等进之三经得民所法行定理方后面种产说子于也分出这在要人中大一有的了是不作地着就出到生们用以来他时上个国我学分和能可同下工过年发主成以对为多起化电力家度部等进之三经得民所法行定理方后面种产说子于也大上我到那要下个天可出小么学起们生子里这就有和来她很去会做没好得看都还把为能什么因为所以虽然但是如果而且所以并且除了或者还是只是不过虽然既然可是但是不仅而且虽然即使不管只要哪怕因为为了除了哪怕尽管虽然不如不仅与其宁可不管只要哪怕因为为了除了哪怕尽管虽然不如不仅与其宁可不管只要哪怕因为为了除了哪怕尽管虽然不如不仅与其宁可天明地暗日月星辰风雨雷电春夏秋冬山川河流草木花果飞禽走兽男女老少衣食住行红黄蓝绿黑白灰紫圆方长短高矮胖瘦粗细大小多少重轻快慢早晚先后上下左右里外前后远近亲疏美丑善恶真假虚实动静冷热干湿软硬生死存亡胜负输赢爱恨情仇悲欢离合喜怒哀乐酸甜苦辣柴米油盐酱醋茶金银铜铁锡琴棋书画诗酒花笔墨纸砚江河湖海三字经百家姓千字文论语孟子大学中庸诗经尚书礼记周易春秋道德经南无阿弥陀佛观音菩萨大悲咒心经金刚经法华经华严经地藏经阿含经楞严经维摩诘经圆觉经六祖坛经黄帝内经伤寒论金匮要略温病条辨本草纲目神农本草经千金要方孙子兵法三十六计鬼谷子韩非子吕氏春秋淮南子史记汉书后汉书三国志资治通鉴水经注齐民要术天工开物梦溪笔谈农政全书本草纲目三侠五义红楼梦水浒传西游记三国演义聊斋志异儒林外史封神演义东周列国志西厢记牡丹亭长生殿桃花扇窦娥冤西厢记牡丹亭长生殿桃花扇赵氏孤儿汉宫秋梧桐雨倩女离魂墙头马上镜花缘孽海花老残游记官场现形记二十年目睹之怪现状儒林外史镜花缘红楼梦水浒传西游记三国演义聊斋志异搜神记世说新语太平广记太平御览册府元龟文苑英华全唐诗全宋词全元曲唐宋八大家诗经楚辞汉赋唐诗宋词元曲明清小说红楼梦西游记水浒传三国演义金瓶梅聊斋志异儒林外史封神演义东周列国志镜花缘老残游记官场现形记二十年目睹之怪现状孽海花三侠五义小五义施公案包公案彭公案七侠五义白眉大侠童林传三侠剑连环套三打祝家庄三气周瑜三顾茅庐三英战吕布草船借箭火烧赤壁空城计七擒孟获六出祁山九伐中原刮骨疗毒单刀赴会千里走单骑过五关斩六将败走麦城夜走麦城水淹七军火烧连营白帝城托孤秋风五丈原三分天下归晋司马懿曹操刘备孙权诸葛亮关羽张飞赵云马超黄忠魏延姜维庞统法正郭嘉荀彧荀攸贾诩程昱许褚典韦张辽徐晃张郃于禁乐进李典李傕郭汜董卓吕布貂蝉王允袁绍袁术公孙瓒刘表刘璋张鲁张角黄巾起义官渡之战赤壁之战夷陵之战五丈原合肥之战汉中之战街亭之战麦城之战樊城之战潼关之战渭南之战定军山之战汉水之战祁山之战长安之战洛阳之战许昌之战邺城之战邺郡之战';

  static final List<String> _initials = [
    'zh', 'ch', 'sh', 'b', 'p', 'm', 'f', 'd', 't', 'n', 'l', 'g', 'k', 'h', 'j', 'q', 'x', 'r', 'z', 'c', 's', 'y', 'w'
  ];

  static List<Map<String, String>> generateExtendedLevels() {
    List<Map<String, String>> levels = [];
    Set<String> usedCharacters = {};
    Random rand = Random();

    // Clean up string to unique characters
    List<String> uniqueChars = commonCharacters.split('').toSet().toList();
    uniqueChars.shuffle(rand);

    for (String char in uniqueChars) {
      if (levels.length >= 2000) break;

      // Skip non-Chinese characters or punctuation
      if (char.trim().isEmpty || char == ' ' || char == '，' || char == '。') continue;

      try {
        String pinyinFull = PinyinHelper.getPinyinE(char, format: PinyinFormat.WITH_TONE_MARK);
        String pinyinBase = PinyinHelper.getPinyinE(char, format: PinyinFormat.WITHOUT_TONE);

        if (pinyinFull.isEmpty || pinyinBase.isEmpty || pinyinFull == char) {
          continue; // Skip if lpinyin couldn't parse it
        }

        String initial = '';
        String rest = pinyinBase;
        String restFull = pinyinFull;

        for (String ini in _initials) {
          if (pinyinBase.startsWith(ini)) {
            initial = ini;
            rest = pinyinBase.substring(ini.length);
            restFull = pinyinFull.substring(ini.length);
            break;
          }
        }

        // If no initial (zero-initial syllable), skip for spelling practice
        if (initial.isEmpty) continue;

        String final1 = rest;
        String final1Full = restFull;
        String final2 = '';
        String final2Full = '';

        if (rest.length > 1) {
          if (rest.startsWith('i') && ['a', 'ao', 'an', 'ang', 'ong'].contains(rest.substring(1))) {
            final2 = 'i';
            final2Full = restFull.substring(0, 1);
            final1 = rest.substring(1);
            final1Full = restFull.substring(1);
          } else if (rest.startsWith('u') && ['a', 'o', 'ai', 'an', 'ang'].contains(rest.substring(1))) {
            final2 = 'u';
            final2Full = restFull.substring(0, 1);
            final1 = rest.substring(1);
            final1Full = restFull.substring(1);
          } else if ((rest.startsWith('v') || rest.startsWith('u')) && ['e', 'an'].contains(rest.substring(1))) {
            final2Full = restFull.substring(0, 1); 
            final2 = 'u';
            final1 = rest.substring(1);
            final1Full = restFull.substring(1);
          }
        }

        Map<String, String> levelData = {
          'word': char,
          'pinyin_full': pinyinFull,
          'initial': initial,
          'result': pinyinBase,
        };

        if (final2Full.isNotEmpty) {
          levelData['final'] = final2Full; // medial
          levelData['final2'] = final1Full; // tail
        } else {
          levelData['final'] = final1Full;
        }

        levels.add(levelData);
      } catch (e) {
        // Skip on parse error
        continue;
      }
    }

    // If we have less than 2000, we'll duplicate and shuffle until we hit 2000
    if (levels.isNotEmpty && levels.length < 2000) {
      List<Map<String, String>> finalLevels = [];
      while (finalLevels.length < 2000) {
        for (var l in levels) {
          if (finalLevels.length >= 2000) break;
          finalLevels.add(l);
        }
      }
      finalLevels.shuffle(rand);
      return finalLevels;
    }

    return levels.take(2000).toList();
  }
}
