import '/backend/backend.dart';
import '/components/web_components/side_nav/side_nav_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryItem {
  final String id;
  final String title;
  final String description;
  final String imageAsset;
  final String? route;
  final Map<String, dynamic>? queryParameters;
  final BoxFit imageFit;
  final bool isSpecialRoute;

  const CategoryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    this.route,
    this.queryParameters,
    this.imageFit = BoxFit.cover,
    this.isSpecialRoute = false,
  });
}

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  int assignmentNo = 0;

  int testNo = 0;

  int otherNo = 0;

  int todayClassCount = 0;

  int premiumAccountsCount = -1;

  // Category card lists (reorderable)
  late List<CategoryItem> academicsItems;
  late List<CategoryItem> toolsItems;
  late List<CategoryItem> campusLifeItems;

  static const defaultAcademics = [
    CategoryItem(
      id: 'about_aastu',
      title: 'About AASTU',
      description: 'Brief description Addis Ababa Science and Technology University',
      imageAsset: 'assets/images/catagory_icon13.png',
      route: 'AASTU',
    ),
    CategoryItem(
      id: 'academic_calendar',
      title: 'Academic Calendar',
      description: 'Academic calendar of all consecutive batchs, UG and PG',
      imageAsset: 'assets/images/catagory_icon0.png',
      route: 'AcademicCalendar',
    ),
    CategoryItem(
      id: 'grading_system',
      title: 'Grading System',
      description: 'Final grades of students in the undergraduate',
      imageAsset: 'assets/images/catagory_icon8.png',
      route: 'GradingSystem',
    ),
    CategoryItem(
      id: 'students_handbook',
      title: 'Students handbook',
      description: 'Offical handbook for AASTU Students',
      imageAsset: 'assets/images/catagory_icon9.png',
      route: 'StudentsHandBook',
    ),
  ];

  static const defaultTools = [
    CategoryItem(
      id: 'class_schedule',
      title: 'Class Schedule',
      description: 'Build your weekly timetable and never miss a class.',
      imageAsset: 'assets/images/catagory_icon0.png',
      route: 'classSchedule',
    ),
    CategoryItem(
      id: 'grade_calculator',
      title: 'Grade Calculator',
      description: 'Calculate your grade easly. you can save your grade history.',
      imageAsset: 'assets/images/catagory_icon1.png',
      route: 'grade_calulator',
    ),
    CategoryItem(
      id: 'quiz_generator',
      title: 'Quiz Generator',
      description: 'Create quiz questions based on course topics using AI.',
      imageAsset: 'assets/images/catagory_icon5.png',
      route: 'QuizPage',
    ),
    CategoryItem(
      id: 'virtual_id',
      title: 'Virtual ID Card (beta)',
      description: 'Get your virtual ID card to use with the app.',
      imageAsset: 'assets/images/phone.png',
      imageFit: BoxFit.contain,
      isSpecialRoute: true,
    ),
    CategoryItem(
      id: 'student_portal',
      title: 'Student Portal',
      description: 'Visit official aastu students portal of the college',
      imageAsset: 'assets/images/catagory_icon14.png',
      route: 'StudentsPortalWeb',
      imageFit: BoxFit.contain,
      queryParameters: {'url': 'https://studentinfo.aastu.edu.et/'},
    ),
  ];

  static const defaultCampusLife = [
    CategoryItem(
      id: 'campus_gallery',
      title: 'Campus Gallery',
      description: 'Explore the campus through photos and videos',
      imageAsset: 'assets/images/catagory_icon11.png',
      route: 'Gallery',
    ),
    CategoryItem(
      id: 'religious_communities',
      title: 'Religious Communities',
      description: 'Find religious communities and fellowships on campus',
      imageAsset: 'assets/images/catagory_icon6.png',
      route: 'ReligiousCommunity',
    ),
    CategoryItem(
      id: 'associations_clubs',
      title: 'Associations and Clubs',
      description: 'Find student led associations and clubs within the college',
      imageAsset: 'assets/images/catagory_icon3.png',
      route: 'EngineersAssoc',
      imageFit: BoxFit.contain,
    ),
  ];

  List<CategoryItem> reorderFromSaved(List<CategoryItem> defaults, List<String>? savedOrder) {
    if (savedOrder == null || savedOrder.isEmpty) return List.from(defaults);
    final map = {for (var item in defaults) item.id: item};
    final result = <CategoryItem>[];
    for (final id in savedOrder) {
      if (map.containsKey(id)) {
        result.add(map.remove(id)!);
      }
    }
    result.addAll(map.values);
    return result;
  }

  Future<void> loadCategoryOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final academicsOrder = prefs.getStringList('category_order_academics');
    final toolsOrder = prefs.getStringList('category_order_tools');
    final campusLifeOrder = prefs.getStringList('category_order_campus_life');
    academicsItems = reorderFromSaved(defaultAcademics, academicsOrder);
    toolsItems = reorderFromSaved(defaultTools, toolsOrder);
    campusLifeItems = reorderFromSaved(defaultCampusLife, campusLifeOrder);
  }

  Future<void> saveCategoryOrder(String tabKey, List<CategoryItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(tabKey, items.map((e) => e.id).toList());
  }

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  ConstantsRecord? latestVersion;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  DailyNegaritRecord? myDailyNegarit;
  // Stores action output result for [Firestore Query - Query a collection] action in home widget.
  List<MyNotesRecord>? myNotes;
  // Stores action output result for [Custom Action - countNotesItems] action in home widget.
  List<int>? getTaskNoList;
  // Model for Side_nav component.
  late SideNavModel sideNavModel;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  @override
  void initState(BuildContext context) {
    sideNavModel = createModel(context, () => SideNavModel());
  }

  @override
  void dispose() {
    sideNavModel.dispose();
    tabBarController?.dispose();
  }
}
