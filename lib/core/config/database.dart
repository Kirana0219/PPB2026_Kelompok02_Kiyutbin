import 'package:supabase_flutter/supabase_flutter.dart';

class Database {
  Database._();

  static SupabaseClient get client =>
      Supabase.instance.client;
}