import 'dart:io';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: dart tools/create_feature.dart <feature_name>');
    exit(1);
  }

  final feature = args.first.toLowerCase();
  final pascalName = feature
      .split('_')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join('');
  final basePath = 'lib/features/$feature';

  final structure = {
    // --- DATA LAYER ---
    // Local data sources
    '$basePath/data/sources/local/dao': ['${feature}_dao.dart'],
    '$basePath/data/sources/local/entity': ['${feature}_entity.dart'],

    // Remote data sources
    '$basePath/data/sources/remote/model': ['${feature}_model.dart'],
    '$basePath/data/sources/remote/repositories': [
      '${feature}_repo.dart',
      'imp_${feature}_repo.dart',
    ],

    // --- VIEW ---
    '$basePath/view/widgets': [
      '${feature}_app_bar.dart',
      '${feature}_body.dart',
      '${feature}_fab.dart',
    ],

    // --- VIEWMODEL LAYER ---
    '$basePath/view': ['${feature}_page.dart'],
    '$basePath/viewmodel': ['${feature}_view_model.dart'],
  };

  for (var entry in structure.entries) {
    final dir = Directory(entry.key);
    if (!dir.existsSync()) dir.createSync(recursive: true);
    for (var fileName in entry.value) {
      final file = File('${entry.key}/$fileName');
      if (!file.existsSync()) {
        final className = fileName
            .replaceAll('.dart', '')
            .split('_')
            .map((e) => e[0].toUpperCase() + e.substring(1))
            .join('');

        String content = '';

        // --- Custom Templates ---
        if (fileName.contains('_view_model.dart')) {
          content =
              '''
import 'package:flutter/material.dart';

class ${pascalName}ViewModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    _counter--;
    notifyListeners();
  }
}
''';
        } else if (fileName.contains('_model.dart')) {
          content =
              '''
import 'package:flutter/material.dart';

class ${pascalName}Model {
  final int id;
  final String title;
  final double description;
  final Color color;

  ${pascalName}Model({
    required this.id,
    required this.title,
    required this.description,
    required this.color,
  });
}
''';
        } else if (fileName.contains('_app_bar.dart')) {
          content =
              '''
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${pascalName}AppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ${pascalName}AppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 0,
      centerTitle: true,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18.0.sp,
            ),
          ),
          const Spacer(),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.search, size: 16.0.r),
                color: Colors.black87,
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications_none, size: 16.0.r),
                color: Colors.black87,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_sharp, size: 16.0.r),
        color: Colors.black87,
        onPressed: () {
          var currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild?.unfocus();
          } else {
            context.router.maybePop();
          }
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0).r,
          child: CircleAvatar(
            radius: 16.0.r,
            backgroundColor: const Color(0xFFB0B8C1),
            child: Text(
              'A',
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
          ),
        ),
      ],
    );
  }
}
''';
        } else if (fileName.contains('_body.dart')) {
          content =
              '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ${pascalName}Body extends StatelessWidget {
  final int counter;

  const ${pascalName}Body({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0.r,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        ],
      ),
    );
  }
}
''';
        } else if (fileName.contains('_fab.dart')) {
          content =
              '''
import 'package:flutter/material.dart';

class ${pascalName}Fab extends StatelessWidget {
  final VoidCallback onPressed;

  const ${pascalName}Fab({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
''';
        } else if (fileName.contains('_page.dart')) {
          content =
              '''
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:zeus_app/core/constants/app_strings.dart';
import 'package:zeus_app/core/utils/extensions.dart';

import 'widgets/${feature}_app_bar.dart';
import 'widgets/${feature}_body.dart';
import 'widgets/${feature}_fab.dart';
import '../viewmodel/${feature}_view_model.dart';

@RoutePage()
class ${pascalName}Page extends StatefulWidget {
  const ${pascalName}Page({super.key});

  @override
  State<${pascalName}Page> createState() => _${pascalName}PageState();
}

class _${pascalName}PageState extends State<${pascalName}Page> {
  late ${pascalName}ViewModel _${feature}ViewModel;
  int _counter = 0;

  void _incrementCounter() {
    _${feature}ViewModel.incrementCounter();
  }

  @override
  void initState() {
    _${feature}ViewModel = context.read${pascalName}VM();
    _counter = _${feature}ViewModel.counter;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _${feature}ViewModel = context.watch${pascalName}VM();
    _counter = _${feature}ViewModel.counter;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: ${pascalName}AppBar(title: Constants.titleViewReport),
      body: ${pascalName}Body(counter: _counter),
      floatingActionButton: ${pascalName}Fab(onPressed: _incrementCounter),
    );
  }
}
''';
        } else {
          content =
              '''
class $className {
  // TODO: Implement $className
}
''';
        }

        file.writeAsStringSync(content);
      }
    }
  }

  print('Flutter feature "$feature" created successfully!');
}
