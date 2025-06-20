import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String firstName;
  final String middleName;
  final String lastName;
  final String nickName;

  const HomePage({
    super.key,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.nickName,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.95, end: 1.05).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fullName = widget.firstName;

    if (widget.middleName.isNotEmpty) {
      fullName += ' ${widget.middleName}';
    }

    fullName += ' ${widget.lastName}';

    if (widget.nickName.isNotEmpty) {
      fullName += " or ${widget.nickName}.";
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 250, 255, 1),
      body: Center(
        child: Column(
          children: [

            const SizedBox(height: 20),

            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 28, right: 28),
                child: Text.rich(
                  TextSpan(
                      children: [
                        TextSpan(
                          text: 'Listening for\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.grey.shade800,
                          ),
                        ),

                        TextSpan(
                          text: widget.firstName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color.fromRGBO(8, 129, 208, 1),
                          ),
                        ),

                        if (widget.middleName.isNotEmpty)
                          TextSpan(
                            text: ' ${widget.middleName}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Color.fromRGBO(8, 129, 208, 1),
                            ),
                          ),
                        TextSpan(
                          text: ' ${widget.lastName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Color.fromRGBO(8, 129, 208, 1),
                          ),
                        ),

                        if (widget.nickName.isNotEmpty) ...[
                          TextSpan(
                            text: ' or ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          TextSpan(
                            text: widget.nickName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 26,
                              color: Color.fromRGBO(8, 129, 208, 1),
                            ),
                          ),
                        ],

                        TextSpan(
                          text: '.',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.grey.shade800,
                          ),
                        )

                      ]
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            SizedBox(height: 25),

            // logo
            Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 30.0,
              ),
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'lib/images/icon.png',
                  fit: BoxFit.contain,
                  height: 120,
                  width: 300,
                  color: Color.fromRGBO(8, 129, 208, 1),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 260,
                  width: 275,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}