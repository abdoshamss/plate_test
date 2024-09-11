import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

// import '../../modules/auth/domain/model/auth_model.dart';
import '../../features/chat/domain/model/chat_details_model.dart';
import '../utils/utils.dart';

class DataManager {
  late BoxCollection collection;
  static late Box userData;

  static const USER = "USER";

  Future initHive() async {
    await Hive.initFlutter();
    userData = await Hive.openBox('dataUser');

    // final directory = await getApplicationDocumentsDirectory();
    // collection = await BoxCollection.open(
    //   'dataManager', // Name of your database
    //   {'data'}, // Names of your boxes
    //   path: directory
    //       .path, // Path where to store your boxes (Only used in Flutter / Dart IO)
    // );
  }

/////
  Future<void> saveData(String key, dynamic value) async {
    final box = await Hive.openBox('data');
    await box.put(key, value);
  }

  saveUser(Map<String, dynamic> value) async {
    // await Hive.initFlutter();
    final userData = await Hive.openBox('dataUser');
    await userData.put(USER, value);
  }

  getData(String key) async {
    // await Hive.initFlutter();
    final box = await Hive.openBox('data');

    return box.get(key);
  }

  static getUserData() async {
    // final userData = await Hive.openBox('dataUser');

    try {
      print("Hive" * 88);
      final user = (Map<String, dynamic>.from(userData.get(USER)));
      Utils.token = user['access_token'];
      print("HiveToken");
      print(Utils.token.toString());

      // Utils.userModel = UserModel.fromJson(Map<String, dynamic>.from(user));

      return userData.get(USER);
    } catch (e) {
      log(e.toString());
      //  userData.clear();
    }
  }

  deleteUserData() async {
    // final userData = await Hive.openBox('dataUser');
    print("Deleeeeeeteee");
    return await userData.delete(USER);
  }

  deleteAllData() async {
    final userData = await Hive.openBox('data');

    return userData.delete(USER);
  }

  late Box localMessage;

  deleteAllMsgs() async => await localMessage.clear();

  addMsg(
    Message message,
  ) async =>
      await localMessage.put(
        message.createdAt.toString(),
        await message.msgSave(),
      );

  deleteMsg(String key) async => await localMessage.delete(key);

  updateMsg(String key, Message msg) async =>
      await localMessage.put(key, await msg.msgSave());

  // Future<MessageModel> getMessage(String key) async =>
  //     MessageModel.fromHive(await localMessage.get(key));

  //  ;
  Future<List<Message>?> getMsgs(String roomId, String FromId) async {
    List<Message> messages = [];
    for (Map element in localMessage.values) {
      final message = Message.fromHive(element);
      if (message.isSender == true && message.roomId == roomId) {
        messages.add(message);
      }
    }
    return messages.reversed.toList();
  }
}
