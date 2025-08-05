import 'package:get/get.dart';
import 'package:sharely/utils/assets_utils.dart';
import 'dart:async';
import '../../../base/base_controller.dart';

class RewardsController extends BaseController {
  // 奖励池列表
  final rewardPools = <RewardPoolItem>[].obs;
  
  // 倒计时定时器
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _initRewardPools();
    _startCountdown();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  // 初始化奖励池列表
  void _initRewardPools() {
    rewardPools.addAll([
      RewardPoolItem(
        logo: AssetsUtils.alpha_ic,
        title: 'Sharely Reward Pool',
        brand: 'Sharely',
        isOfficial: true,
        totalPrice: 5000,
        currentAmount: 13680,
        goalAmount: 20000,
        goalLabel: 'GMV Goal',
        joinedCount: 1593,
        endTime: DateTime.now().add(Duration(hours: 12, minutes: 24, seconds: 12)),
        avatars: ['https://picsum.photos/32/32?random=1', 'https://picsum.photos/32/32?random=2', 'https://picsum.photos/32/32?random=3', 'https://picsum.photos/32/32?random=4', 'https://picsum.photos/32/32?random=5'],
      ),
      RewardPoolItem(
        logo: AssetsUtils.alpha_ic,
        title: 'All-in-one Magic Power Bank',
        brand: 'Snazzy Tech',
        isOfficial: false,
        isHot: true,
        totalPrice: 5000,
        currentAmount: 6000,
        goalAmount: 10000,
        goalLabel: 'Sales Goal',
        goalUnit: 'units',
        joinedCount: 1593,
        endTime: DateTime.now().add(Duration(hours: 12, minutes: 24, seconds: 12)),
        avatars: ['https://picsum.photos/32/32?random=6', 'https://picsum.photos/32/32?random=7', 'https://picsum.photos/32/32?random=8', 'https://picsum.photos/32/32?random=9', 'https://picsum.photos/32/32?random=10'],
      ),
    ]);
  }

  // 开始倒计时
  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 检查是否还有未结束的倒计时
      bool hasActiveCountdown = false;
      
      for (var pool in rewardPools) {
        if (pool.endTime.isAfter(DateTime.now())) {
          hasActiveCountdown = true;
          // 只更新单个项目的时间显示，不刷新整个列表
          pool.updateFormattedTime();
        }
      }
      
      // 如果所有倒计时都结束了，停止定时器
      if (!hasActiveCountdown) {
        _timer?.cancel();
      }
    });
  }

  // 解锁奖励
  void unlockRewards(RewardPoolItem pool) {
    // TODO: 实现解锁奖励逻辑
    Get.snackbar('解锁奖励', '${pool.title} 奖励解锁功能开发中...');
  }

  @override
  Future<void> fetchData() async {
  }
}

// 奖励池项目模型
class RewardPoolItem {
  final String logo;
  final String title;
  final String brand;
  final bool isOfficial;
  final bool isHot;
  final int totalPrice;
  final int currentAmount;
  final int goalAmount;
  final String goalLabel;
  final String goalUnit;
  final int joinedCount;
  final DateTime endTime;
  final List<String> avatars;
  
  // 添加响应式的格式化时间变量
  final formattedTime = ''.obs;

  RewardPoolItem({
    required this.logo,
    required this.title,
    required this.brand,
    this.isOfficial = false,
    this.isHot = false,
    required this.totalPrice,
    required this.currentAmount,
    required this.goalAmount,
    required this.goalLabel,
    this.goalUnit = '',
    required this.joinedCount,
    required this.endTime,
    required this.avatars,
  }) {
    // 初始化时间显示
    updateFormattedTime();
  }

  // 获取进度百分比
  double get progress => (currentAmount / goalAmount).clamp(0.0, 1.0);

  // 获取剩余时间
  Duration get remainingTime {
    final now = DateTime.now();
    if (endTime.isAfter(now)) {
      return endTime.difference(now);
    }
    return Duration.zero;
  }

  // 更新格式化时间 - 只更新当前项目的时间显示
  void updateFormattedTime() {
    final remaining = remainingTime;
    if (remaining.inSeconds <= 0) {
      formattedTime.value = '00D : 00H : 00M : 00S';
      return;
    }
    
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;
    
    formattedTime.value = '${days.toString().padLeft(2, '0')}D : ${hours.toString().padLeft(2, '0')}H : ${minutes.toString().padLeft(2, '0')}M : ${seconds.toString().padLeft(2, '0')}S';
  }
} 