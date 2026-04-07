import 'package:flutter/material.dart';

class ForecastTabBar extends StatefulWidget {
  final ValueNotifier<int> tabNotifier;

  const ForecastTabBar({super.key, required this.tabNotifier});

  @override
  State<ForecastTabBar> createState() => _ForecastTabBarState();
}

class _ForecastTabBarState extends State<ForecastTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = ['Today', 'Tomorrow', 'Next 3 Days'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
        widget.tabNotifier.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 330,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildGlassTabBar(context, scheme),
          _buildDots(),
        ],
      ),
    );
  }
  Widget _buildGlassTabBar(BuildContext, context){
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(50),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: Colors.transparent,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(4),
        child: TabBar(
          controller: _tabController,
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          dividerColor: Colors.transparent,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey.withAlpha(10),
            border: Border.all(
              color: Colors.white.withAlpha(20),
              width: 1,
            ),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          tabs: _tabs.map((e) => Tab(height: 36, text: e)).toList(),
        ),
      ),
    );
  }
  Widget _buildDots(){
    return AnimatedBuilder(
        animation: _tabController.animation!,
        builder: (context, _){
          final animValue = _tabController.animation!.value;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(_tabs.length, (i){
              final selected = (1.0 - (animValue - i).abs()).clamp(0.0, 1.0);
              final size = 5.0 + (selected * 3.0);
              final color = Color.lerp(
               Colors.grey,
                  Colors.white,
                  selected,

              )!;
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              );
            }),
          );
        });
  }
}
