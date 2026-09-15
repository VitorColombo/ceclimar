import 'package:flutter/material.dart';

enum PhosphorIconsStyle { thin, light, regular, bold, fill, duotone }

class PhosphorIcons {
  static IconData caretDown([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.keyboard_arrow_down;
  static IconData facebookLogo([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.facebook;
  static IconData instagramLogo([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.camera_alt;
  static IconData youtubeLogo([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.smart_display;
  static IconData envelopeSimple([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.email_outlined;
  static IconData spotifyLogo([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.music_note;
  static IconData telegramLogo([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.send;
  static IconData house([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => style == PhosphorIconsStyle.fill ? Icons.home : Icons.home_outlined;
  static IconData list([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.list;
  static IconData user([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => style == PhosphorIconsStyle.fill ? Icons.person : Icons.person_outline;
  static IconData info([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => style == PhosphorIconsStyle.fill ? Icons.info : Icons.info_outline;
  static IconData mapPin([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.location_on_outlined;
  static IconData calendarBlank([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.calendar_today_outlined;
  static IconData pencilSimple([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.edit_outlined;
  static IconData funnel([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.filter_alt_outlined;
  static IconData arrowSquareIn([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.input;
  static IconData export([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.file_upload_outlined;
  static IconData trash([PhosphorIconsStyle style = PhosphorIconsStyle.regular]) => Icons.delete_outline;
}

class PhosphorIconsLight {
  static const IconData download = Icons.download_outlined;
  static const IconData share = Icons.share_outlined;
}

class PhosphorIcon extends StatelessWidget {
  const PhosphorIcon(this.icon, {super.key, this.size, this.color});

  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) => Icon(icon, size: size, color: color);
}