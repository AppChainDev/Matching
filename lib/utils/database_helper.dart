import 'package:rinlin/models/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> deleteExistingDatabase() async {
    String path = join(await getDatabasesPath(), 'matching_app.db');
    await deleteDatabase(path);
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'matching_app.db');
    
    // Optional: Delete the existing database for testing purposes
    await deleteExistingDatabase();
    
    return await openDatabase(
      path,
      version: 3, // Updated version to 3
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER,
        prefecture_id INTEGER,
        avatar TEXT,
        state TEXT,
        time TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE messages (
        id INTEGER PRIMARY KEY,
        user_id INTEGER,
        text TEXT,
        image_path TEXT,
        timestamp TEXT,
        is_sent_by_me INTEGER,
        FOREIGN KEY(user_id) REFERENCES users(id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE messages ADD COLUMN image_path TEXT
      ''');
    }

    if (oldVersion < 3) {
      // Create a new table without the 'gender' column
      await db.execute('''
        CREATE TABLE users_temp (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER,
          prefecture_id INTEGER,
          avatar TEXT,
          state TEXT,
          time TEXT
        )
      ''');

      // Copy data from the old 'users' table to the new 'users_temp' table
      await db.execute('''
        INSERT INTO users_temp (id, name, age, prefecture_id, avatar, state, time)
        SELECT id, name, age, prefecture_id, avatar, state, time FROM users
      ''');

      // Drop the old 'users' table
      await db.execute('DROP TABLE users');

      // Rename 'users_temp' to 'users'
      await db.execute('ALTER TABLE users_temp RENAME TO users');
    }
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<int> insertMessage(Map<String, dynamic> message) async {
    Database db = await database;
    return await db.insert('messages', message);
  }

  Future<List<Map<String, dynamic>>> getMessages(int userId) async {
    Database db = await database;
    return await db.query(
      'messages',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp ASC',
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  Future<Map<String, dynamic>?> getLastMessageForUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(
      'messages',
      where: 'user_id = ?',
      whereArgs: [userId],
      orderBy: 'timestamp DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<User>> getUsersWithLastMessageSentByMe() async {
    final db = await database;

    // Get the last message for each user and ensure it's the one sent by me
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT users.id, users.name, users.age, users.prefecture_id, users.avatar, users.state, users.time
      FROM users
      INNER JOIN (
        SELECT user_id, MAX(timestamp) as last_timestamp
        FROM messages
        GROUP BY user_id
      ) AS user_last_messages ON users.id = user_last_messages.user_id
      INNER JOIN messages ON messages.user_id = user_last_messages.user_id AND messages.timestamp = user_last_messages.last_timestamp
      WHERE messages.is_sent_by_me = 1
    ''');

    return result.map((json) => User.fromJson(json)).toList();
}
}
