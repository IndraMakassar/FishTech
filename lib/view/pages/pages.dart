import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/bloc/pond/pond_bloc.dart';
import 'package:fishtech/injection_container.dart';
import 'package:fishtech/model/pond_card_model.dart';
import 'package:fishtech/model/pond_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:fishtech/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:fishtech/view/widgets/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:fishtech/bloc/notification/notif_bloc.dart';
import 'package:fishtech/utils/date_time_formatter.dart';
import 'dart:math' show min, max;

part 'add_pond_screen.dart';
part 'article_screen.dart';
part 'detail_kolam_screen.dart';
part 'history_screen.dart';
part 'home_screen.dart';
part 'login_screen.dart';
part 'notification_page.dart';
part 'profile_screen.dart';
part 'register_screen.dart';
part 'scan_qr.dart';
part 'add_machine_screen.dart';
part 'statistics_screen.dart';
part 'settingsPond_screen.dart';