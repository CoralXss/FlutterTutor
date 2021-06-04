import 'package:flutter/material.dart';

/// 知识点：如何管理状态？
/// 多种方式，是由 widget本身 或是 父widget，取决于实际情况。
/// 常见管理方式：（1）widget 管理自己的 state；（2）父widget 管理 widget 状态；（3）混搭管理。
/// 可按以下原则：
/// - 如果状态是用户数据，如 CheckBox 选中状态、滑块的位置，则该状态最好由父widget管理；
/// - 如果状态是有关界面效果的，如动画，则交由widget自身管理。

