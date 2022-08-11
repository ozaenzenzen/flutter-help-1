import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:tailorine_mobilev2/screens/sign_in_screen.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // bool isTapped = false;
    return Scaffold(
      backgroundColor: bgColor,
      body: IntroductionScreen(
        globalBackgroundColor: bgColor,
        isProgress: true,
        isTopSafeArea: true,
        isBottomSafeArea: true,
        pages: [
          PageViewModel(
            titleWidget: Text(
              'Cari Tailor!',
              style: subtitleTextStyle.copyWith(fontSize: 20),
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24),
              child: Text(
                'Cari tailor berkualitas anti ribet, dengan detail lengkap dan katalog tailor yang bisa jadi referensi kamu.',
                style: regularTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            image: Image.asset(
              'assets/illustration/1.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width,
            ),
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 64, bottom: 10),
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'Buat janji temu dengan mudah!',
              style: subtitleTextStyle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text.rich(
              TextSpan(children: [
                TextSpan(
                  text:
                      'Kamu bisa ajukan janji temu mulai dari 1 minggu sebelum bertemu tailor. Buat janji temu untuk mulai',
                  style: regularTextStyle,
                ),
                TextSpan(
                  text: ' #kastemsesukamu',
                  style: regularTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ]),
              style: regularTextStyle,
              textAlign: TextAlign.center,
            ),
            image: Image.asset(
              'assets/illustration/2.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
            ),
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 64),
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              'Beri ulasan tentang tailor kamu!',
              style: subtitleTextStyle.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            bodyWidget: Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24),
              child: Text(
                'Bantu tailor kembangkan usahanya dengan berikan ulasan mengenai pelayanan mereka.',
                style: regularTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            image: Image.asset(
              'assets/illustration/3.png',
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9,
              fit: BoxFit.cover,
            ),
            decoration: PageDecoration(
              imagePadding: EdgeInsets.only(top: 64),
            ),
          ),
        ],
        showDoneButton: true,
        onDone: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInPage(),
          ),
        ),
        // overrideDone:
        // Container(
        //       height: 50,
        //       width: double.infinity,
        //       margin: EdgeInsets.only(top: 30, left: 24, right: 24),
        //       child: TextButton(
        //         onPressed: () => Navigator.of(context).push(
        //           MaterialPageRoute(
        //             builder: (context) => SignInPage(),
        //           ),
        //         ),
        //         style: TextButton.styleFrom(
        //           backgroundColor: primaryColor,
        //           shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(12),
        //           ),
        //         ),
        //         child: Text(
        //           'Get Started',
        //           style: regularTextStyle.copyWith(
        //             fontSize: 16,
        //             fontWeight: FontWeight.w500,
        //           ),
        //         ),
        //       ),
        //     ) ,
        showSkipButton: true,
        dotsDecorator: DotsDecorator(
          color: Colors.grey,
          activeColor: secondaryColor,
          activeSize: Size(10, 10),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),

        baseBtnStyle: TextButton.styleFrom(
          enableFeedback: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        skip: Text(
          'Skip',
        ),
        next: Text(
          'Next',
          style: regularTextStyle.copyWith(color: primaryColor),
        ),
        done: Text(
          'Done',
          style: regularTextStyle.copyWith(color: primaryColor),
        ),
        doneStyle: TextButton.styleFrom(
          side: BorderSide(
            color: primaryColor,
            width: 1,
          ),
          backgroundColor: bgColor,
        ),
        nextStyle: TextButton.styleFrom(
          side: BorderSide(
            color: primaryColor,
            width: 1,
          ),
          backgroundColor: bgColor,
        ),
        skipStyle: TextButton.styleFrom(
          primary: textColor,
          backgroundColor: bgColor,
        ),
      ),
    );
  }
}
