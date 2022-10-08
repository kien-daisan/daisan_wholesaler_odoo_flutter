
import 'package:flutter_project_structure/constants/menu_images.dart';

class ProfileMenuItems {
  int id = 0;
  String title = '';
  String icon = AppImages.placeholder;

  ProfileMenuItems({required this.id, required this.title, required this.icon});

  ProfileMenuItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['icon'] = icon;
    return data;
  }
}