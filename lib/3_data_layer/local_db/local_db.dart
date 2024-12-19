import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import '../models/app_user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_users.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        imageUrl TEXT,
        joinDate INTEGER NOT NULL,
        fcmToken TEXT
      )
    ''');
  }

  // Create
  Future<void> createUser(AppUser user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Read (Single User)
  Future<AppUser?> getUserById(String id) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return AppUser.fromMap(maps.first);
    } else {
      return null; // No user found
    }
  }

  // Read (All Users)
  Future<List<AppUser>> getAllUsers() async {
    final db = await database;
    final maps = await db.query('users');

    return List<AppUser>.from(maps.map((map) => AppUser.fromMap(map)));
  }

  // Update
  Future<void> updateUser(AppUser user) async {
    final db = await database;
    await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Delete
  Future<void> deleteUser(String id) async {
    final db = await database;
    await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close Database
  Future<void> closeDatabase() async {
    final db = await _database;
    if (db != null) {
      await db.close();
    }
  }
}

void generateLocalDbData() async {
  final dbHelper = DatabaseHelper();

  // Create a new user
  final user = AppUser(
    id: Uuid().v1(),
    name: 'John Doe',
    email: 'johndoe@example.com',
    phoneNumber: '1234567890',
    imageUrl: null,
    joinDate: DateTime.now(),
    fcmToken: null,
  );
  await dbHelper.createUser(user);

  // Get all users
  final users = await dbHelper.getAllUsers();
  print('All Users: $users');

  // Get a user by ID
  final fetchedUser = await dbHelper.getUserById('1');
  print('Fetched User: $fetchedUser');

  // Update the user
  final updatedUser = AppUser(
    id: Uuid().v1(),
    name: 'John Smith',
    email: 'johnsmith@example.com',
    phoneNumber: '0987654321',
    imageUrl: null,
    joinDate: user.joinDate,
    fcmToken: 'new_fcm_token',
  );
  await dbHelper.updateUser(updatedUser);

  // // Delete the user
  // await dbHelper.deleteUser('1');
}
