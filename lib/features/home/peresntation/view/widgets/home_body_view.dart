import 'package:flutter/material.dart';

import '../../view_model/model/dashboard_model.dart';
import 'dashboard_bottom_widgets.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1,
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: DashboardBottomWidget(
                  lottiePath:
                      DashboardBottomModel.dashboardBottomList(context)[index]
                          .lottiePath,
                  title:
                      DashboardBottomModel.dashboardBottomList(context)[index]
                          .text,
                  function: () {
                    DashboardBottomModel.dashboardBottomList(context)[index]
                        .function();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
