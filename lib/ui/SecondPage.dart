import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String payload;

  const SecondPage({
    required this.payload,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Second page - Payload:',
              ),
              const SizedBox(height: 8),
              Text(
                payload,
              ),
              const SizedBox(height: 8),
              RaisedButton(
                child: Text('Back'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
}
