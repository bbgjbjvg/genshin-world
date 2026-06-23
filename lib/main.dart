import 'package:flutter/material.dart';

void main() {
  runApp(const GenshinWorldApp());
}

class GenshinWorldApp extends StatelessWidget {
  const GenshinWorldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '原神·世界',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F23),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B5CF6),
          secondary: Color(0xFFA78BFA),
          surface: Color(0xFF1E1D35),
          error: Color(0xFFEF4444),
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

// ============================================================
// 主界面
// ============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  final List<_TabItem> _tabs = const [
    _TabItem(label: '首页'),
    _TabItem(label: '世界'),
    _TabItem(label: '角色'),
    _TabItem(label: '图鉴'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            _buildStatusBar(context),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Header
                    _buildHeader(),

                    const SizedBox(height: 24),

                    // Hero Card
                    const _HeroCard(),

                    const SizedBox(height: 24),

                    // Section: 七国
                    _buildSectionTitle('七国'),
                    const SizedBox(height: 12),

                    // Nations Grid
                    const _NationsGrid(),

                    const SizedBox(height: 24),

                    // Section: 最新收录
                    _buildSectionTitle('最新收录'),
                    const SizedBox(height: 12),

                    // Latest Items
                    const _LatestList(),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // Bottom Tab Bar
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '11:11',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF8FAFC),
              letterSpacing: 0.3,
            ),
          ),
          Row(
            children: [
              _statusIcon(Icons.signal_cellular_alt, 12),
              const SizedBox(width: 6),
              _statusIcon(Icons.wifi, 12),
              const SizedBox(width: 6),
              _statusIcon(Icons.battery_full, 14),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statusIcon(IconData icon, double size) {
    return Icon(icon, color: const Color(0xFFF8FAFC), size: size);
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '原神·世界',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFF8FAFC),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '提瓦特大陆全览 · 世界观收录',
          style: TextStyle(
            fontSize: 14,
            color: const Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFF8FAFC),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.fromLTRB(21, 12, 21, 21),
      color: Colors.transparent,
      child: Container(
        height: 62,
        decoration: BoxDecoration(
          color: const Color(0xFF1E1D35),
          borderRadius: BorderRadius.circular(36),
          border: Border.all(
            color: const Color(0xFF4C1D95),
            width: 1,
          ),
        ),
        child: Row(
          children: List.generate(_tabs.length, (index) {
          final tab = _tabs[index];
          final isActive = index == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isActive ? const Color(0xFF8B5CF6) : Colors.transparent,
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Label on top
                    Text(
                      tab.label,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF94A3B8),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Icon below
                    SizedBox(
                      width: 18,
                      height: 18,
                      child: _buildTabIcon(tab, isActive),
                    ),
                  ],
                ),
              ),
            ),
          );
          }),
        ),
      ),
    );
  }
  Widget _buildTabIcon(_TabItem tab, bool isActive) {
    final color = isActive ? Colors.white : const Color(0xFF94A3B8);
    if (tab.label == '首页') return _HouseIcon(color: color);
    if (tab.label == '世界') return _PrimogemIcon(color: color);
    if (tab.label == '角色') return _SilhouetteIcon(color: color);
    if (tab.label == '图鉴') return _BookIcon(color: color);
    return const SizedBox();
  }
}

class _TabItem {
  final String label;
  const _TabItem({
    required this.label,
  });
}

// ============================================================
// 自定义 Tab 图标 - 原神主题
// ============================================================

/// 房子图标
class _HouseIcon extends StatelessWidget {
  final Color color;
  const _HouseIcon({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _HousePainter(color),
      size: const Size(18, 18),
    );
  }
}

class _HousePainter extends CustomPainter {
  final Color color;
  _HousePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeJoin = StrokeJoin.round;
    // Roof + walls
    final house = Path()
      ..moveTo(2.5, 9.5)
      ..lineTo(9, 3)
      ..lineTo(15.5, 9.5)
      ..lineTo(15.5, 16)
      ..lineTo(2.5, 16)
      ..close();
    canvas.drawPath(house, p);
    // Door
    canvas.drawPath(
      Path()..moveTo(7, 16)..lineTo(7, 11)..lineTo(11, 11)..lineTo(11, 16), p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

/// 原石图标（菱形宝石）
class _PrimogemIcon extends StatelessWidget {
  final Color color;
  const _PrimogemIcon({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PrimogemPainter(color), size: const Size(18, 18));
  }
}

class _PrimogemPainter extends CustomPainter {
  final Color color;
  _PrimogemPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final s = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.3;
    final f = Paint()..color = color.withOpacity(0.2)..style = PaintingStyle.fill;
    final outer = Path()..moveTo(9, 2)..lineTo(15, 9)..lineTo(9, 16)..lineTo(3, 9)..close();
    canvas.drawPath(outer, s); canvas.drawPath(outer, f);
    final i = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 0.8;
    canvas.drawLine(const Offset(9, 2), const Offset(9, 16), i);
    canvas.drawLine(const Offset(3, 9), const Offset(15, 9), i);
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

/// 空荧镂空头像（旅行者剪影）
class _SilhouetteIcon extends StatelessWidget {
  final Color color;
  const _SilhouetteIcon({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SilhouettePainter(color), size: const Size(18, 18));
  }
}

class _SilhouettePainter extends CustomPainter {
  final Color color;
  _SilhouettePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 1.3;
    canvas.drawCircle(const Offset(9, 5.5), 3, p);
    canvas.drawPath(Path()
      ..moveTo(4, 15.5)..lineTo(5.5, 10.5)
      ..quadraticBezierTo(9, 9, 12.5, 10.5)..lineTo(14, 15.5), p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

/// 图书带标签图标
class _BookIcon extends StatelessWidget {
  final Color color;
  const _BookIcon({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BookPainter(color), size: const Size(18, 18));
  }
}

class _BookPainter extends CustomPainter {
  final Color color;
  _BookPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.stroke
      ..strokeWidth = 1.3..strokeCap = StrokeCap.round;
    canvas.drawRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(3, 3, 12, 12), const Radius.circular(2)), p);
    canvas.drawLine(const Offset(9, 3), const Offset(9, 15), p);
    canvas.drawPath(Path()
      ..moveTo(12, 3)..lineTo(12, 8)
      ..lineTo(13.5, 6.5)..lineTo(15, 8)..lineTo(15, 3), p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

// ============================================================
// Hero 卡片
// ============================================================
class _HeroCard extends StatelessWidget {
  const _HeroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF0D337F),
            Color(0xFF338CE6),
            Color(0xFF7C4DFF),
          ],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          // Text overlay
          const Positioned(
            left: 24,
            top: 36,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '探索提瓦特',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '七大王国 · 无尽传说',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          // Bottom-right decorative text
          const Positioned(
            right: 16,
            bottom: 16,
            child: Text(
              'Teyvat',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white10,
                letterSpacing: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 七国网格
// ============================================================
class _NationsGrid extends StatelessWidget {
  const _NationsGrid();

  static const List<_NationData> _nations = [
    _NationData(name: '蒙德', element: '风', color: Color(0xFF98D8C8)),
    _NationData(name: '璃月', element: '岩', color: Color(0xFFF4D03F)),
    _NationData(name: '稻妻', element: '雷', color: Color(0xFFBB8FCE)),
    _NationData(name: '须弥', element: '草', color: Color(0xFF7DCEA0)),
    _NationData(name: '枫丹', element: '水', color: Color(0xFF85C1E9)),
    _NationData(name: '纳塔', element: '火', color: Color(0xFFF1948A)),
    _NationData(name: '至冬', element: '冰', color: Color(0xFFA3E4D7)),
  ];

  @override
  Widget build(BuildContext context) {
    // 2-column responsive grid
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 12) / 2; // gap is 12
        return Column(
          children: [
            Row(
              children: [
                _NationCard(data: _nations[0], width: cardWidth),
                const SizedBox(width: 12),
                _NationCard(data: _nations[1], width: cardWidth),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _NationCard(data: _nations[2], width: cardWidth),
                const SizedBox(width: 12),
                _NationCard(data: _nations[3], width: cardWidth),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _NationCard(data: _nations[4], width: cardWidth),
                const SizedBox(width: 12),
                _NationCard(data: _nations[5], width: cardWidth),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _NationCard(data: _nations[6], width: cardWidth),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _NationData {
  final String name;
  final String element;
  final Color color;
  const _NationData({
    required this.name,
    required this.element,
    required this.color,
  });
}

class _NationCard extends StatelessWidget {
  final _NationData data;
  final double width;

  const _NationCard({
    required this.data,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1D35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: data.color.withOpacity(0.6),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFF8FAFC),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.element,
            style: TextStyle(
              fontSize: 12,
              color: data.color,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// 最新收录
// ============================================================
class _LatestList extends StatelessWidget {
  const _LatestList();

  static const List<_LatestItemData> _items = [
    _LatestItemData(
      title: '原神主线剧情时间线梳理',
      description: '从开篇到最新章节的全览',
    ),
    _LatestItemData(
      title: '七国历史 · 魔神战争简史',
      description: '魔神战争如何塑造了七国格局',
    ),
    _LatestItemData(
      title: '天理与深渊的终极秘密',
      description: '坎瑞亚覆灭背后的真相',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_items.length, (index) {
        return Padding(
          padding: EdgeInsets.only(bottom: index < _items.length - 1 ? 12 : 0),
          child: _LatestItem(data: _items[index]),
        );
      }),
    );
  }
}

class _LatestItemData {
  final String title;
  final String description;
  const _LatestItemData({
    required this.title,
    required this.description,
  });
}

class _LatestItem extends StatelessWidget {
  final _LatestItemData data;
  const _LatestItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        children: [
          // Thumbnail placeholder
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF27273B),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.auto_stories,
              color: Color(0xFF4C1D95),
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          // Text column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF8FAFC),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: Color(0xFF4C1D95),
            size: 20,
          ),
        ],
      ),
    );
  }
}
