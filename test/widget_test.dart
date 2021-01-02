// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/features/home_page/home_page.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/state/app_state/actions/screen_changing_actions.dart';
import 'package:todo_app/state/app_state/app_state.dart';
import 'package:todo_app/utils/app_router.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/tile_item.dart';

void main() {
  testWidgets(
    'App State initial test',
    (WidgetTester tester) async {
      final Store<AppState> store = Store<AppState>(initialState: AppState.initState());
      final storeTester = StoreTester<AppState>.from(store);
      expect(storeTester.state.pageIndex, 0);
      expect(storeTester.state.todoList, isEmpty);
      expect(storeTester.state.title, 'Active');

      // Build our app and trigger a frame.
      await tester.pumpWidget(TodoApp(store: store));

      // Verify active list is empty / empty active to do's caption displayed
      expect(find.text(activeEmpty), findsOneWidget);

      // for future reference
      // Verify that our counter starts at 0.
      // expect(find.text('0'), findsOneWidget);
      // expect(find.text('1'), findsNothing);

      // Tap the '+' icon and trigger a frame.
      // await tester.tap(find.byIcon(Icons.add));
      // await tester.pump();

      // Verify that our counter has incremented.
      // expect(find.text('0'), findsNothing);
      // expect(find.text('1'), findsOneWidget);
    },
  );

  testWidgets(
    'Dispatch Action Test',
    (WidgetTester tester) async {
      final Store<AppState> store = Store<AppState>(initialState: AppState.initState());
      final storeTester = StoreTester<AppState>.from(store);
      expect(storeTester.state.pageIndex, 0);
      expect(storeTester.state.todoList, isEmpty);
      expect(storeTester.state.title, 'Active');

      final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

      // Build our app and trigger a frame.
      await tester.pumpWidget(
        StoreProvider<AppState>(
          store: store,
          child: MaterialApp(
            home: StoreConnector<AppState, MainViewModel>(
              model: MainViewModel(),
              builder: (context, viewModel) {
                return Scaffold(
                  key: scaffoldKey,
                  drawer: Drawer(
                    child: ListView(
                      children: [
                        const SizedBox(height: kToolbarHeight),
                        TileItem(
                          iconData: Icons.lightbulb_outline,
                          title: active,
                          onTap: (context) {
                            StoreProvider.dispatch<AppState>(
                                context, ChangeScreenAction(title: 'Active', pageIndex: 0));
                            Future.delayed(const Duration(milliseconds: 200), () => Navigator.pop(context));
                          },
                          focusColor: Colors.blue[600],
                          isSelected: viewModel.pageIndex == 0,
                        ),
                        TileItem(
                          iconData: Icons.done_all_outlined,
                          title: accomplished,
                          onTap: (context) {
                            StoreProvider.dispatch<AppState>(
                                context, ChangeScreenAction(title: 'Accomplished', pageIndex: 1));
                            Future.delayed(const Duration(milliseconds: 200), () => Navigator.pop(context));
                          },
                          focusColor: Colors.red[600],
                          isSelected: viewModel.pageIndex != 0,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            initialRoute: HomePage.route,
            onGenerateRoute: AppRouter.generateRoute,
          ),
        ),
      );

      await tester.pump(); // trigger frame
      expect(find.byType(Drawer), findsNothing); // no drawer found
      scaffoldKey.currentState?.openDrawer(); // opens drawer

      await tester.pump(); // drawer should have started animating at this point
      expect(find.text('Active'), findsOneWidget); // after opening drawer, widget with a text of 'Active' exists
      await tester.tap(find.byType(Container).at(1)); // click widget with text of 'Accomplished'
      storeTester
          .dispatch(ChangeScreenAction(title: 'Accomplished', pageIndex: 1)); // set title: 'Accomplished', pageIndex: 1
      await tester.pump(const Duration(milliseconds: 200)); // must animate after 200 milliseconds

      await tester.pump(); // trigger frame again
      expect(find.byType(Drawer), findsNothing); // no drawer found
      scaffoldKey.currentState?.openDrawer(); // opens drawer again

      await tester.pump(); // trigger frame containing drawer items
      expect(find.text('Accomplished'), findsOneWidget); // opens drawer, must have widget with a text of 'Accomplished'
      final TestInfo<AppState> info = await storeTester.wait(ChangeScreenAction); // get updated state
      expect(info.state.title, 'Accomplished'); // expected title: 'Accomplished'
      expect(info.state.pageIndex, 1); // expected pageIndex: 1
      await tester.tap(find.byType(Container).at(0)); // click widget with a text of 'Active'
      storeTester.dispatch(ChangeScreenAction(title: 'Active', pageIndex: 0)); // set title: 'Active', pageIndex: 0
      await tester.pump(const Duration(milliseconds: 200)); // must animate after 200 milliseconds
      final TestInfo<AppState> changeInfo = await storeTester.wait(ChangeScreenAction); // get updated state
      expect(changeInfo.state.title, 'Active'); // expected title: 'Active'
      expect(changeInfo.state.pageIndex, 0); // expected pageIndex: 0
    },
  );
}
