import 'package:flutter/material.dart';
import 'package:formandlogin/src/bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _createLoginForm(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final background = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );
    final circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Color.fromRGBO(255, 255, 255, 0.07)
      ),
    );

    return Stack(
      children: <Widget>[
        background,
        Positioned(child: circle, top: 90, left: 30),
        Positioned(child: circle, top: -40, right: -30),
        Positioned(child: circle, bottom: -40, left: 250),
        
        Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 100),
              SizedBox(height: 10, width: double.infinity),
              Text('Example name', style: TextStyle(color: Colors.white, fontSize: 25))
            ],
          ),
        )
      ],
    );
  }

  Widget _createLoginForm(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final bloc = Provider.ofLoginBloc(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow> [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3,
                  offset: Offset(0, 3),
                  spreadRadius: 2
                ),
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Edu', style: TextStyle(fontSize: 20)),
                SizedBox(height: 60),
                _createEmail(bloc),
                SizedBox(height: 30),
                _createPassword(bloc),
                SizedBox(height: 30),
                _createButton(bloc)
              ],
            ),
          ),

          Text('¿Olvidó la contraseña?'),

          SizedBox(height: 100)
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      }
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: Colors.deepPurple),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            onChanged: bloc.changePassword,
          ),
        );
      }
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: Text('Acceder'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
          elevation: 0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      }
    );
  }

  _login(LoginBloc bloc, BuildContext context) {
    print("====================");
    print("Email: ${bloc.email}");
    print("Email: ${bloc.password}");
    print("====================");
    Navigator.pushReplacementNamed(context, 'home');
  }
}
