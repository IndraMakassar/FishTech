import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fishtech/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:bloc_test/bloc_test.dart';
import 'package:fishtech/bloc/auth/auth_bloc.dart';
import 'package:fishtech/view/pages/pages.dart';
import 'package:fishtech/view/widgets/widgets.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';


part 'unit/profileData_test.dart';
part 'widget/register_test.dart';
part 'widget/logout_test.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}
class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockAuthRepository extends Mock implements AuthRepository {}
class MockGoRouter extends Mock implements GoRouter {}

void main(){
  runLogoutTests();
}