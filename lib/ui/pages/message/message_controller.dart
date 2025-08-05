import 'package:get/get.dart';
import 'package:sharely/base/base_controller.dart';
import 'package:sharely/main.dart';

class MessageController extends BaseController {
  final messageList = <MessageModel>[].obs;

  @override
  Future<void> fetchData() async {
    // 模拟网络请求延迟
    await Future.delayed(const Duration(milliseconds: 500));
    
    messageList.value = [
      MessageModel(
        id: '1',
        name: 'Olga Harrison',
        avatar: testImg,
        message: 'Could you please check the inbox? Thanks!',
        time: '2分钟前',
        isRead: false,
      ),
      MessageModel(
        id: '2',
        name: 'John Smith',
        avatar: testImg,
        message: 'The meeting has been rescheduled to tomorrow.',
        time: '5分钟前',
        isRead: true,
      ),
      MessageModel(
        id: '3',
        name: 'Sarah Johnson',
        avatar: testImg,
        message: 'Thanks for your help with the project!',
        time: '10分钟前',
        isRead: true,
      ),
      MessageModel(
        id: '4',
        name: 'Mike Wilson',
        avatar: testImg,
        message: 'Can you review the document I sent?',
        time: '1小时前',
        isRead: false,
      ),
      MessageModel(
        id: '5',
        name: 'Lisa Brown',
        avatar: testImg,
        message: 'Great work on the presentation!',
        time: '2小时前',
        isRead: true,
      ),
    ];
  }

  void markAsRead(String messageId) {
    final index = messageList.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      messageList[index] = messageList[index].copyWith(isRead: true);
      messageList.refresh();
    }
  }

  void deleteMessage(String messageId) {
    messageList.removeWhere((msg) => msg.id == messageId);
  }
}

class MessageModel {
  final String id;
  final String name;
  final String avatar;
  final String message;
  final String time;
  final bool isRead;

  MessageModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.message,
    required this.time,
    required this.isRead,
  });

  MessageModel copyWith({
    String? id,
    String? name,
    String? avatar,
    String? message,
    String? time,
    bool? isRead,
  }) {
    return MessageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      message: message ?? this.message,
      time: time ?? this.time,
      isRead: isRead ?? this.isRead,
    );
  }
} 