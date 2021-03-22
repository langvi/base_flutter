import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangeAnimation extends Animation<double>
    with AnimationWithParentMixin<double> {
  ChangeAnimation(this.controller);

  final TabController controller;

  @override
  Animation<double> get parent => controller.animation;

  @override
  void removeStatusListener(AnimationStatusListener listener) {
    if (parent != null) super.removeStatusListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    if (parent != null) super.removeListener(listener);
  }

  @override
  double get value => _indexChangeProgress(controller);
}

double _indexChangeProgress(TabController controller) {
  final double controllerValue = controller.animation.value;
  final double previousIndex = controller.previousIndex.toDouble();
  final double currentIndex = controller.index.toDouble();
  if (!controller.indexIsChanging)
    return (currentIndex - controllerValue).abs().clamp(0.0, 1.0) as double;
  return (controllerValue - currentIndex).abs() /
      (currentIndex - previousIndex).abs();
}

class ItemTab extends AnimatedWidget {
  final Key key;
  final bool isSelected;
  final Animation<double> animation;
  final int currentIndex;
  final int itemIndex;
  final double offset;
  ItemTab({
    this.key,
    this.isSelected,
    this.currentIndex,
    this.itemIndex,
    this.offset,
    this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Color color;
    bool isDragtoRight = itemIndex > currentIndex;
    if (isDragtoRight) {
      if (itemIndex >= currentIndex && itemIndex <= currentIndex + 1) {
        color = isSelected
            ? Color.lerp(Colors.red, Colors.grey, animation.value)
            : Color.lerp(Colors.grey, Colors.red, animation.value);
      }
    } else {
      if (itemIndex >= currentIndex - 1 && itemIndex <= currentIndex) {
        color = isSelected
            ? Color.lerp(Colors.red, Colors.grey, animation.value)
            : Color.lerp(Colors.grey, Colors.red, animation.value);
      }
    }
    return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
        child: SvgPicture.asset(
          'images/icon_active.svg',
          color: color,
        ));
  }
}
