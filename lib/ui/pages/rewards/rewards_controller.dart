import 'package:get/get.dart';
import '../../../base/base_controller.dart';

class RewardsController extends BaseController {
  // 用户积分
  final myPoints = 7152.obs;
  
  // 钱包连接状态
  final isWalletConnected = false.obs;
  
  // 关注状态
  final isFollowingX = false.obs;
  
  // 奖励列表
  final rewards = <RewardItem>[].obs;
  
  // 社交任务列表
  final socialQuests = <SocialQuestItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initRewards();
    _initSocialQuests();
  }

  // 初始化奖励列表
  void _initRewards() {
    rewards.addAll([
      RewardItem(
        icon: 'wallet_ic',
        title: 'Wallet Wrangler',
        description: 'Connect a Solana wallet (+300)',
        buttonText: 'Connect wallet',
        isCompleted: false,
      ),
      RewardItem(
        icon: 'duck_ic',
        title: 'X Spy',
        description: 'Follow us on X',
        buttonText: 'Follow',
        isCompleted: false,
      ),
    ]);
  }

  // 初始化社交任务列表
  void _initSocialQuests() {
    socialQuests.addAll([
      SocialQuestItem(
        icon: 'wallet_ic',
        title: 'Wallet Wrangler',
        description: 'Connect a Solana wallet (+300)',
        buttonText: 'Connect wallet',
        isCompleted: false,
      ),
      SocialQuestItem(
        icon: 'duck_ic',
        title: 'X Spy',
        description: 'Follow us on X',
        buttonText: 'Connect wallet',
        isCompleted: false,
      ),
    ]);
  }

  // 连接钱包
  void connectWallet() {
    // TODO: 实现钱包连接逻辑
    isWalletConnected.value = true;
    // 更新相关奖励状态
    for (var reward in rewards) {
      if (reward.title == 'Wallet Wrangler') {
        reward.isCompleted = true;
        myPoints.value += 300;
        break;
      }
    }
    rewards.refresh();
  }

  // 关注X
  void followX() {
    // TODO: 实现关注X的逻辑
    isFollowingX.value = true;
    // 更新相关奖励状态
    for (var reward in rewards) {
      if (reward.title == 'X Spy') {
        reward.isCompleted = true;
        break;
      }
    }
    rewards.refresh();
  }

  // 查看积分历史
  void viewPointHistory() {
    // TODO: 导航到积分历史页面
    Get.snackbar('积分历史', '功能开发中...');
  }

  @override
  Future<void> fetchData() async {
  }
}

// 奖励项目模型
class RewardItem {
  final String icon;
  final String title;
  final String description;
  final String buttonText;
  bool isCompleted;

  RewardItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.isCompleted,
  });
}

// 社交任务项目模型
class SocialQuestItem {
  final String icon;
  final String title;
  final String description;
  final String buttonText;
  bool isCompleted;

  SocialQuestItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.isCompleted,
  });
} 