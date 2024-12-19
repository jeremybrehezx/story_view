import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:refreshed/refreshed.dart';

class StoryReactionController<T> extends GetxController {
  final RxMap<String, List<T>> reactions = RxMap<String, List<T>>({});
  final RxMap<String, List<int>> firstReactions = RxMap<String, List<int>>({});
  final RxList<FeedReaction> socialReactions = RxList<FeedReaction>();
  final RxList<AnimatedEmoji> animatedReactionsNoAnim = RxList<AnimatedEmoji>();
  final RxList<AnimatedEmoji> animatedReactions = RxList<AnimatedEmoji>();
  final RxnInt userId = RxnInt();

  final Rxn<Future<void> Function(String, FeedReaction?)> reactionClick =
      Rxn<Future<void> Function(String, FeedReaction?)>();
  final Rxn<void Function(List)> showReactionSheet = Rxn<void Function(List)>();
}
