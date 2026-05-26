import 'package:flutter/material.dart';

import '../features/accident_alert/accident_alert_page.dart';
import '../features/auth/forgot_password_code_page.dart';
import '../features/auth/forgot_password_email_page.dart';
import '../features/auth/forgot_password_new_password_page.dart';
import '../features/auth/forgot_password_success_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/connections/add_connection_page.dart';
import '../features/connections/connections_page.dart';
import '../features/daily_tasks/daily_tasks_page.dart';
import '../features/home/home_page.dart';
import '../features/medical_tracking/medical_tracking_page.dart';
import '../features/pharmacies/pharmacies_map_page.dart';
import '../features/settings/settings_page.dart';
import '../features/splash/splash_page.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const forgotPasswordEmail = '/forgot-password-email';
  static const forgotPasswordCode = '/forgot-password-code';
  static const forgotPasswordNewPassword = '/forgot-password-new-password';
  static const forgotPasswordSuccess = '/forgot-password-success';
  static const home = '/home';
  static const connections = '/connections';
  static const addConnection = '/add-connection';
  static const settings = '/settings';
  static const pharmaciesMap = '/pharmacies-map';
  static const dailyTasks = '/daily-tasks';
  static const medicalTracking = '/medical-tracking';
  static const accidentAlert = '/accident-alert';

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => const SplashPage(),
        login: (_) => const LoginPage(),
        register: (_) => const RegisterPage(),
        forgotPassword: (_) => const ForgotPasswordEmailPage(),
        forgotPasswordEmail: (_) => const ForgotPasswordEmailPage(),
        forgotPasswordCode: (_) => const ForgotPasswordCodePage(),
        forgotPasswordNewPassword: (_) => const ForgotPasswordNewPasswordPage(),
        forgotPasswordSuccess: (_) => const ForgotPasswordSuccessPage(),
        home: (_) => const HomePage(),
        connections: (_) => const ConnectionsPage(),
        addConnection: (_) => const AddConnectionPage(),
        settings: (_) => const SettingsPage(),
        pharmaciesMap: (_) => const PharmaciesMapPage(),
        dailyTasks: (_) => const DailyTasksPage(),
        medicalTracking: (_) => const MedicalTrackingPage(),
        accidentAlert: (_) => const AccidentAlertPage(),
      };
}
