import 'package:flutter/material.dart';
class ForecastTabBar extends StatefulWidget {
  final ValueChanged<int> onTabChanged;

  const ForecastTabBar({super.key,required this.onTabChanged});

  @override
  State<ForecastTabBar> createState() => _ForecastTabBarState();
}

class _ForecastTabBarState extends State<ForecastTabBar> with TickerProviderStateMixin
{
  late TabController _tabController;
  int _selectedIndex = 0;
  final List<String> _tabs = ['Today', 'Tomorrow', 'Next 3 Days'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener((){
      if(!_tabController.indexIsChanging){
        setState(() => _selectedIndex = _tabController.index);
        widget.onTabChanged(_tabController.index);
      }
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
      width: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            splashFactory: NoSplash.splashFactory,
            indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              labelColor: scheme.primary,
              unselectedLabelColor: scheme.onSurface.withValues(alpha: 0.5),
              labelStyle: Theme.of(context).textTheme.titleSmall,
              unselectedLabelStyle: Theme.of(context).textTheme.labelSmall,
              controller: _tabController,
              tabs: _tabs.map((e) => Tab(
                  height: 25,
                  text: e)).toList(),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_tabs.length, (i){
              final isSelected = i == _selectedIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.bounceOut,
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isSelected
                      ? scheme.primary
                      : scheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(99),
                ),
      );
            }),
          )
        ],
      ),
    );
  }
}
