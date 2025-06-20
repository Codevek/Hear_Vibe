import 'package:flutter/material.dart';
import 'package:vibehear/pages/setup_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 250, 255, 1),
      body: Center(
        child: Column(
          children: [

            const SizedBox(height: 90),

            // logo
            Padding(
              padding: const EdgeInsets.only(
                  top: 25.0,
                left: 25.0,
                right: 30.0,
              ),
              child: Image.asset(
                  'lib/images/logo_vibe_hear.png',
                height: 200,
              ),
            ),

            // title
            Center(
              child: Text(
                  'Vibe Hear',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 52,
                  color: Colors.grey[800],
                ),
              ),
            ),
            
            const SizedBox(height: 150),

            // subtitle
            Center(
              child: Text(
                textAlign: TextAlign.center,
                  "Feel the Sound\nStay Connected",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.grey[600],
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 38),

            // start now button
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => SetupPage()
              ),
              ),
              child: Center(
                child: Container(
                  width: 280,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(8, 129, 208, 1)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
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
