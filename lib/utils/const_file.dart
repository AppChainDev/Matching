import 'package:drone/models/community_model.dart';

class ConstFile {
  static const List<String> qualificationsItems = <String>["一等無人航空機操縦士","なし"];
  static const List<String> prefectureItems = <String>[
    "北海道",
    "青森県",
    "岩手県",
    "宮城県",
    "秋田県",
    "山形県",
    "福島県",
    "茨城県",
    "栃木県",
    "群馬県",
    "埼玉県",
    "千葉県",
    "東京都",
    "神奈川県",
    "新潟県",
    "富山県",
    "石川県",
    "福井県",
    "山梨県",
    "長野県",
    "岐阜県",
    "静岡県",
    "愛知県",
    "三重県",
    "滋賀県",
    "京都府",
    "大阪府",
    "兵庫県",
    "奈良県",
    "和歌山県",
    "鳥取県",
    "島根県",
    "岡山県",
    "広島県",
    "山口県",
    "徳島県",
    "香川県",
    "愛媛県",
    "高知県",
    "福岡県",
    "佐賀県",
    "長崎県",
    "熊本県",
    "大分県",
    "宮崎県",
    "鹿児島県",
    "沖縄県"
  ];
  static const List<String> bodyTypes = <String>[
    "スレンダー",
    "細め",
    "普通",
    "グラマー",
    "ぽっちゃり",
    "太め"
  ];
  static const List<String> attitudes = <String>[
    "まだ未定",
    "1年以内には",
    "2〜3年以内にしたい",
    "良い人がいればすぐにでも"
  ];
  static const List<String> bloodItems = <String>[
    "A型",
    "B型",
    "AB型",
    "O型"
  ];
  static const List<String> educationItems = <String>[
    "高校卒",
    "短大・専門卒",
    "大学卒",
    "大学院卒",
    "復学"
  ];
  static const List<String> jobTypes = <String>[
    "大手企業",
    "弁護士",
    "公認会計士",
    "外資系企業",
    "薬剤師",
    "金融系",
    "税理士",
    "消防士",
    "国家公務員",
    "地方公務員",
    "商社",
    "医療系メーカー",
    "医師",
    "IT関連",
    "教育関連",
    "経営者・役員",
    "機械系メーカー",
    "司法書士",
    "コンサル業",
    "電機メーカー",
    "獣医",
    "会社員",
    "飲食業",
  ];
  static const List<String> incomes = <String>[
    "200万円未満",
    "200万円〜300万円",
    "300万円〜400万円",
    "400万円〜600万円",
    "600万円〜800万円",
    "800万円〜1000万円",
    "1000万円以上"
  ];
  static const List<String> maritalHistories= <String>[
    "独身(未婚)",
    "独身(離婚)"
  ];
  static const List<String> childrenItems= <String>[
    "なし",
    "同居中",
    "別居中"
  ];
  static const List<String> houseworkItems= <String>[
    "積極的に参加したい",
    "参加したい",
    "できれば参加したい",
    "苦手",
    "苦手だけど頑張りたい",
  ];
  static const List<String> hopeMeetItems= <String>[
    "まずは会って話したい",
    "気が合えば会いたい",
    "メッセージを重ねてから",
    "会う前に電話したい"
  ];
  static const List<String> dateCostItems= <String>[
    "男性がすべて払う",
    "男性が多めに払う",
    "割り勘",
    "持ってる方が払う",
    "相手と相談して決める",
    "その場の流れ"
  ];
  static const List<String> holidayItem= <String>[
    "土日",
    "平日",
    "不定期",
  ];
  static const List<String> roommateItem= <String>[
    "一人暮らし",
    "実家暮らし",
    "社宅",
    "ペットと一緒",
    "その他"
  ];
  static const List<String> alcoholItem= <String>[
    "飲まない",
    "時々飲む",
    "飲む",
    "よく飲む",
    "その他"
  ];
  static const List<String> smokingItem= <String>[
    "吸わない",
    "時々吸う",
    "吸う",
    "電子タバコなら吸う",
    "相手が嫌なら辞める"
  ];
  static const List<String> savingsItem= <String>[
    "仲良くなったら教える",
    "100万円以上",
    "300万円以上",
    "500万円以上",
    "1000万円以上",
    "2000万円以上",
    "2000万円以上"
  ];

  static final List<CommunityModel> sportsGroupDatas = <CommunityModel>[
    CommunityModel(id: 1, text: "サッカー", image: "football.png"),
    CommunityModel(id: 2, text: "野球", image: "baseball.png"),
    CommunityModel(id: 3, text: "バスケ", image: "basketball.png"),
    CommunityModel(id: 4, text: "テニス", image: "tennis.png"),
    CommunityModel(id: 5, text: "卓球", image: "tabletennis.png"),
    CommunityModel(id: 6, text: "ゴルフ", image: "golf.png"),
    CommunityModel(id: 7, text: "陸上", image: "track.png"),
    CommunityModel(id: 8, text: "マラソン", image: "marathon.png"),
    CommunityModel(id: 9, text: "バトミントン", image: "badminton.png"),
    CommunityModel(id: 10, text: "水泳", image: "swimming.png"),
    CommunityModel(id: 11, text: "スノボー", image: "snowboarding.png"),
  ];
  static final List<CommunityModel> personalityGroupDatas = <CommunityModel>[
    CommunityModel(id: 1, text: "音楽", image: "music.png"),
    CommunityModel(id: 2, text: "映画", image: "movies.png"),
    CommunityModel(id: 3, text: "漫画", image: "cartoon.png"),
    CommunityModel(id: 4, text: "ゲーム", image: "games.png"),
    CommunityModel(id: 5, text: "食べ歩き", image: "eating.png"),
    CommunityModel(id: 6, text: "サウナ", image: "sanua.png"),
    CommunityModel(id: 7, text: "筋トレ", image: "muscle.png"),
    CommunityModel(id: 8, text: "温泉", image: "hotspring.png"),
    CommunityModel(id: 9, text: "釣り", image: "fishing.png"),
    CommunityModel(id: 10, text: "水泳", image: "swimming.png"),
    CommunityModel(id: 11, text: "写真", image: "photo.png"),
  ];
  static final List<CommunityModel> outingDetailDatas = <CommunityModel>[
    CommunityModel(id: 1, text: "旅行", image: "travel.png"),
    CommunityModel(id: 2, text: "キャンプ", image: "camping.png"),
    CommunityModel(id: 3, text: "登山", image: "mountain_climbing.png"),
    CommunityModel(id: 4, text: "散歩", image: "walking.png"),
    CommunityModel(id: 5, text: "ドライブ", image: "driving.png")
  ];
  static final List<CommunityModel> lifeStyleDatas = <CommunityModel>[
    CommunityModel(id: 1, text: "ペット好き", image: "pet_lover.png"),
    CommunityModel(id: 2, text: "電話可", image: "phone.png"),
    CommunityModel(id: 3, text: "真剣恋愛", image: "serious_relationships.png"),
    CommunityModel(id: 4, text: "夜型", image: "nocturnal.png"),
    CommunityModel(id: 5, text: "朝型", image: "morning_person.png")
  ];
  static const String term_summary = "＿＿＿＿＿＿＿＿（以下，「当社」といいます。）は，本ウェブサイト上で提供するサービス（以下,「本サービス」といいます。）における，ユーザーの個人情報の取扱いについて，以下のとおりプライバシーポリシー（以下，「本ポリシー」といいます。）を定めます。";
  static const String term_section1 = "第1条（個人情報）\n「個人情報」とは，個人情報保護法にいう「個人情報」を指すものとし，生存する個人に関する情報であって，当該情報に含まれる氏名，生年月日，住所，電話番号，連絡先その他の記述等により特定の個人を識別できる情報及び容貌，指紋，声紋にかかるデータ，及び健康保険証の保険者番号などの当該情報単体から特定の個人を識別できる情報（個人識別情報）を指します。";
  static const String trackRecord = "農作物の監視や管理にドローンを活用し、作況や病害虫の発生などをリアルタイムで把握することで、効果的な農業生産管理を実現した。これにより、農産物の収穫量や品質の向上に貢献した。建設現場での進捗管理や安全性の確保のために、ドローンを使用して航空写真を撮影し、建設プロジェクトの進行状況をモニタリングした。また、建設現場の安全監視や環境保護活動にも貢献した。観光地やリゾート地での観光客の案内や安全管理、施設の点検などにドローンを利用した。航空撮影や観光名所のパノラマ映像制作など、観光体験の向上に寄与した。";
  static const String biography = "20XX年：航空工学の学位を取得。\n20XX年 - 20XX年：民間航空会社にて航空機整備士として勤務。航空機の保守点検や修理業務に従事。\n20XX年：一等無人航空機操縦士の資格取得。\n20XX年 - 現在：ドローン技術を活かし、災害対応、農業支援、建設業での利用など、さまざまな分野で活動。ドローンを使った空撮や測量、安全管理などの業務に従事。\n20XX年 - 現在：ドローンの教育・指導にも従事。無人航空機の操縦技術や安全性に関する講習会やセミナーの講師を務める。";
  static const String jobtext= "私たちは農地の効果的な管理を目指し、農薬散布の作業を計画しております。このため、貴重なスキルと経験を持つ皆様にお声がけすることとなりました。\nご担当いただく内容は、農地全体への農薬の散布です。以下に詳細を記載いたします。\n作業日時: [指定の日時を記入]\n農地の場所: [農地の場所を記入]\n散布する農薬: [使用する農薬の種類と量を記入]\n支払い条件: [報酬や支払い条件を記入]\nまた、安全性と効率性を確保するため、次の要件を満たすことをお願いいたします。\n適切なライセンスを保有していること\nドローンの操作に関する経験を有していること\n安全な作業を確保するための適切な装備を所有していること\nご興味がありましたら、お気軽にご連絡ください。詳細をご相談させていただきます。";
}