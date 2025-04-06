import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_gif/flutter_gif.dart';

class GifFadeToImageWidget extends StatefulWidget {
  final String gifPath;
  final String imagePath;
  const GifFadeToImageWidget(
      {Key? key, required this.gifPath, required this.imagePath})
      : super(key: key);
  @override
  _GifFadeToImageWidgetState createState() => _GifFadeToImageWidgetState();
}

class _GifFadeToImageWidgetState extends State<GifFadeToImageWidget>
    with SingleTickerProviderStateMixin {
  // late FlutterGifController _gifController;
  bool _isGifFinished = false;

  // TODO: implement initState

  @override
  void initState() {
    super.initState();
    // _gifController = FlutterGifController(vsync: this);
    //     // _gifController.repeat(min: 0, max: 100, period: Duration(seconds: 3));
    //     //
    //     // _gifController.addListener(() {
    //     //   if (_gifController.isCompleted && !_isGifFinished) {
    //     //     setState(() {
    //     //       _isGifFinished = true;
    //     //     });
    //     //   }
    //     // });

  Future.delayed(Duration(seconds: 4), () {
    _isGifFinished = true;
    if(mounted){
    setState(() {

    });
    }
  });


  }

  @override
  void dispose() {
    // _gifController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  AnimatedSwitcher(
      duration: Duration(seconds: 1),
      transitionBuilder:(
          Widget child,
          Animation<double> animation,){

        return FadeTransition(
          opacity: animation,
          child: child,
        );
      } ,

      child: _isGifFinished&&( widget.gifPath!= widget.imagePath)
          ? Container(
            // width: 273.w,
            // height: 574.h,
        margin: EdgeInsets.only(top: 204.h),
            child: Image.asset(widget.imagePath,
              width: 273.w,
              height: 574.h,
            ),
          )
          : Padding(
            padding: EdgeInsets.only(top: 149.h),
            child: Image.asset(
                    widget.gifPath,
                    height: 222.0.h,
                    width: 222.0.w,
                  ),
          ),
    );
  }
}
