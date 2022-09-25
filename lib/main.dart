import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listenable_preferences/data_saver/cubit/date_saver_cubit.dart';
import 'package:listenable_preferences/data_saver/repository/prefs_date_saver_repository.dart';
import 'package:listenable_preferences/first_date_cubit/first_date_cubit.dart';
import 'package:listenable_preferences/second_date_cubit/second_date_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final repository = PrefsDateSaverRepository(prefs);

  runApp(
    BlocProvider(
      create: (context) => DateSaverCubit(repository)..loadDates(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FirstDateCubit()),
        BlocProvider(create: (context) => SecondDateCubit()),
      ],
      child: MaterialApp(
        home: Builder(
          builder: (context) {
            context.read<DateSaverCubit>().stream.listen((state) {
              context.read<FirstDateCubit>().onMainCubitEmits(state);
              context.read<SecondDateCubit>().onMainCubitEmits(state);
            });
            return const HomePage();
          },
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SecondDateCubit, SecondDateState>(
          listener: (context, state) {
            if (state is SecondDateLoaded) {
              _showSnackBar(context, state.dates.last);
            }
          },
        ),
        BlocListener<FirstDateCubit, FirstDateState>(
          listener: (context, state) {
            if (state is FirstDateLoaded) {
              _showBanner(context, state.dates.last);
            }
          },
        ),
      ],
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            context.read<DateSaverCubit>().saveNewDate(DateTime.now());
          },
        ),
        appBar: AppBar(title: const Text('Example App')),
        body: BlocBuilder<DateSaverCubit, DateSaverState>(
          builder: (context, state) {
            if (state is DatesLoaded) {
              return ListView.separated(
                separatorBuilder: (_, __) => const Divider(
                  color: Colors.grey,
                ),
                itemCount: state.dates.length,
                itemBuilder: (context, index) {
                  final date = state.dates[index];
                  return ListTile(
                    title: Text(date.toIso8601String()),
                    subtitle: Text('Position: //${index + 1}'),
                  );
                },
              );
            }

            if (state is DateSaverLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return const Center(
              child: Text('An error occured, check the logs'),
            );
          },
        ),
      ),
    );
  }

  void _showBanner(BuildContext context, DateTime date) {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.indigo,
        content: Text(
          'You saved $date',
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.white),
            onPressed: ScaffoldMessenger.of(context).hideCurrentMaterialBanner,
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, DateTime date) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('You saved $date')),
    );
  }
}
