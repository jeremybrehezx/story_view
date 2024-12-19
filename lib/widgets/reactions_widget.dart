import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:refreshed/refreshed.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/controller/story_reaction_controller.dart';

class ReactionsWidget extends StatelessWidget {
  const ReactionsWidget({
    required this.storyItemId,
    required this.reactionsController,
    required this.storyController,
    Key? key,
  }) : super(key: key);

  final String storyItemId;
  final StoryReactionController reactionsController;
  final StoryController storyController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (reactionsController.reactions.value[storyItemId]?.isNotEmpty ??
              false)
            GestureDetector(
              onTap: () {
                reactionsController.showReactionSheet.value!.call(
                  reactionsController.reactions.value[storyItemId]!,
                );
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.fromLTRB(
                  2,
                  0,
                  12,
                  0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final id in reactionsController
                            .firstReactions.value[storyItemId] ??
                        [])
                      Transform.scale(
                        scale: 0.5,
                        child: reactionsController
                            .animatedReactionsNoAnim.value[id],
                      ),
                    Text(
                      reactionsController.reactions.value[storyItemId]?.length
                              .toString() ??
                          '0',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            const SizedBox(),
          if (reactionsController.seenByIdMap.value[storyItemId]?.isNotEmpty ??
              false)
            GestureDetector(
              onTap: () {
                storyController.pause();
                reactionsController.showSeenBySheet.value!.call(
                  reactionsController.seenByIdMap.value[storyItemId] ?? [],
                  storyItemId,
                );
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.fromLTRB(
                  2,
                  0,
                  12,
                  0,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 248, 248),
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          weight: 0.5,
                        ),
                      ),
                      Text(
                        reactionsController
                                .seenByIdMap.value[storyItemId]?.length
                                .toString() ??
                            '0',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          FlutterFeedReaction(
            reactions: reactionsController.socialReactions.value,
            containerWidth: 360,
            dragSpace: 50.0,
            dragStart: 10.0,
            onReactionSelected: (val) async =>
                await reactionsController.reactionClick.value!.call(
              storyItemId,
              val,
            ),
            onPressed: () async =>
                await reactionsController.reactionClick.value!.call(
              storyItemId,
              null,
            ),
            prefix: ColorFiltered(
              colorFilter: ColorFilter.mode(
                reactionsController.reactions.value[storyItemId]
                            ?.firstWhereOrNull(
                          (element) =>
                              element.author ==
                              reactionsController.userId.value,
                        ) !=
                        null
                    ? Colors.transparent
                    : Colors.white,
                reactionsController.reactions.value[storyItemId]
                            ?.firstWhereOrNull(
                          (element) =>
                              element.author ==
                              reactionsController.userId.value,
                        ) !=
                        null
                    ? BlendMode.saturation
                    : BlendMode.srcIn,
              ),
              child: reactionsController.reactions.value[storyItemId]
                          ?.firstWhereOrNull(
                        (element) =>
                            element.author == reactionsController.userId.value,
                      ) !=
                      null
                  ? reactionsController.animatedReactions.value[
                      reactionsController.reactions.value[storyItemId]!
                          .firstWhereOrNull(
                            (element) =>
                                element.author ==
                                reactionsController.userId.value,
                          )!
                          .emoji]
                  : const AnimatedEmoji(
                      AnimatedEmojis.thumbsUp,
                      size: 28,
                      animate: false,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
