import 'package:flutter/material.dart';

import '../../app/routes.dart';
import '../daily_tasks/controllers/daily_tasks_controller.dart';
import '../medical_tracking/controllers/medical_tracking_controller.dart';
import 'widgets/home_bottom_nav.dart';
import 'widgets/home_card.dart';
import 'widgets/home_header.dart';
import 'widgets/home_sidebar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const _userName = 'Ana Mendes';

  void _openAccidentAlert(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.accidentAlert);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final dailyTasksController = DailyTasksController.instance;
    final medicalTrackingController = MedicalTrackingController.instance;

    return Scaffold(
      drawer: const HomeSidebar(),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) {
                        return HomeHeader(
                          onProfileTap: () => Scaffold.of(context).openDrawer(),
                        );
                      },
                    ),
                    Divider(height: 1, color: theme.dividerColor),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 34, 24, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bom dia, $_userName!',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 28),
                            AnimatedBuilder(
                              animation: medicalTrackingController,
                              builder: (context, _) {
                                return MedicalFollowUpCard(
                                  healthLevel:
                                      '${medicalTrackingController.dailyHealthLevelText}/5',
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.medicalTracking,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 22),
                            AnimatedBuilder(
                              animation: dailyTasksController,
                              builder: (context, _) {
                                return DailyTasksCard(
                                  progress: dailyTasksController.progress,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    AppRoutes.dailyTasks,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const HomeBottomNav(),
                  ],
                ),
                Positioned(
                  right: 22,
                  bottom: 72,
                  child: _AlertButton(onTap: () => _openAccidentAlert(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AlertButton extends StatelessWidget {
  const _AlertButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: const Color(0xFFFF3B3B),
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF0069B8),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            Icons.campaign_outlined,
            color: Theme.of(context).colorScheme.onSurface,
            size: 34,
          ),
        ),
      ),
    );
  }
}
