import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/repo/orders_repo.dart';
import 'package:notes/repo/user_repo.dart';
import 'package:notes/ui/screens/auth/auth_screen.dart';
import 'package:notes/ui/screens/user/bloc/user_cubit.dart';
import 'package:notes/ui/screens/user/bloc/user_states.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final _emailTextController = TextEditingController();
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  UserCubit _userCubit;

  @override
  void initState() {
    super.initState();
    _userCubit = UserCubit(RepositoryProvider.of<UserRepository>(context));
    _userCubit.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: BlocConsumer(
        cubit: _userCubit,
        builder: (BuildContext context, UserState state) {
          if (state is UserLoadedState) {
            _emailTextController.text = state.user.email;
            _loginTextController.text = state.user.login;
            return Column(
              children: [
                Text(
                  'Email: ',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _emailTextController,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'Login: ',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _loginTextController,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'Password: ',
                  style: TextStyle(fontSize: 18),
                ),
                TextField(
                  controller: _passwordTextController,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 24.0,
                ),
              ],
            );
          } else if (state is UserLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          } else if (state is UserErrorState) {
            return Center(
              child: _buildTryAgain(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            );
          }
        },
        listener: (BuildContext context, state) {
          if (state is UserDeletedState) {
            RepositoryProvider.of<OrdersRepository>(context).clearOrders();
            Navigator.of(context).pop();
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (newContext) => AuthScreen()));
          }
        },
      ),
    );
  }

  Widget _buildTryAgain() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _userCubit.loadUser();
        },
        child: Text('Reload'),
      ),
    );
  }
}
