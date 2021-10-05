import 'dart:async';
import 'dart:math';
import 'dart:ui'as ui;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class UploadModel extends StatefulWidget {
  final double imageMicroWidth;
  const UploadModel({Key? key, required this.imageMicroWidth})
      : super(key: key);

  @override
  _UploadModelState createState() => _UploadModelState();
}

class _UploadModelState extends State<UploadModel> {

  Future<ui.Image> _getImage(link) {
    Image image = new Image.network(link);
    Completer<ui.Image> completer = new Completer<ui.Image>();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
    }));
    return completer.future;
  }

  late double imageWidth;
  Offset p1 = Offset(0, 0), p2 = Offset(0, 0);
  bool focusMode = false, lengthMode = false, widthMode = false;
  GlobalKey photoKey = GlobalKey();
  bool idleMode = true;
  PhotoViewController _controller = PhotoViewController();
  late List<Offset> points;
  late WidthPainter widthPainter;
  late LengthPainter lengthPainter;
  late FocusPainter focusPainter;
  Color idleColor = Colors.grey;
  Color focusedColor = Colors.white;
  Color selectedColor = Colors.green;
GlobalKey photoViewKey = GlobalKey();
GlobalKey clipKey = GlobalKey();
ImageProvider imageProvider = AssetImage('assets/images/example.jpg');
RegExp regex = RegExp(r"([\d])");
NetworkImage networkImage = NetworkImage('https://i.ibb.co/pKPyH80/2.jpg');
 late Image image;
@override
  void initState() {

   image = Image(image: networkImage);
    super.initState();
  }
  @override

  double getSizeImage(){



  return 2;
  }


  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: ClipRect(
            key: clipKey,
            child: Container(
              height: 300,
              width: 400,
              child: Stack(
                children: [
                  GestureDetector(
                    onPanEnd: (details) {
                      if (widthMode) {
                        print('the width of organisme is:' + (this.widget.imageMicroWidth/imageWidth/_controller.scale!.toDouble()*widthPainter.getDistance()).toString() +
                            (pixelRealSize(
                                        photoKey, this.widget.imageMicroWidth) /
                                    _controller.scale!.toDouble() *
                                    widthPainter.getDistance())
                                .toString());
                        print(_controller.scale);
                      }
                      if (lengthMode) {
                        print('the length of organism is:' +
                            (this.widget.imageMicroWidth/ imageWidth /
                                    _controller.scale!.toDouble() *
                                    lengthPainter.getLength())
                                .toString());
                        print(LengthPainter(points: points));
                      }
                      if (focusMode) {}
                    },
                    onPanStart: (DragStartDetails details) {
                      setState(() {
                        p1 = details.localPosition;
                        points = [p1];
                        p2 = details.localPosition;
                      });
                    },
                    onPanUpdate: (DragUpdateDetails details) {
                      if (widthMode) {
                        setState(() {
                          p2 = details.localPosition;
                        });
                      } else if (lengthMode) {
                        setState(() {
                          points.add(details.localPosition);
                        });
                      } else {
                        setState(() {
                          p2 = details.localPosition;
                        });
                      }
                    },
                    child: CustomPaint(
                      key: photoViewKey,
                        child: PhotoView(
                          tightMode: true,
                          key: photoKey,
                          disableGestures: widthMode || lengthMode || focusMode,
                          controller: _controller,
                          initialScale: 1.0,
                          imageProvider:
                              networkImage,
                        ),
                        foregroundPainter: widthMode
                            ? widthPainter = WidthPainter(p1: p1, p2: p2)
                            : lengthMode
                                ? lengthPainter = LengthPainter(points: points)
                                : focusMode
                                    ? focusPainter = FocusPainter(
                                        startPoint: p1, endPoint: p2)
                                    : null),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: focusMode ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                child: TextButton(
                  onPressed: () async {


                    ui.Image myimage = (await _getImage('https://i.ibb.co/pKPyH80/2.jpg')) ;
                imageWidth=myimage.width.toDouble();
                  print(myimage.width);









                    print(image.width);
                    print(_controller.scale);
                    setState(() {
                      if (!focusMode) {
                        focusMode = true;
                        lengthMode = widthMode = false;
                        print(_controller.position);
                      } else {
                        lengthMode = false;
                        focusMode = widthMode = false;
                      }
                    });
                  },
                  child: Text(
                    "focus",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: lengthMode ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      points = [];
                    });
                    if (!lengthMode) {
                      setState(() {
                        lengthMode = true;
                        focusMode = widthMode = false;
                      });
                    } else {
                      setState(() {
                        lengthMode = false;
                        focusMode = widthMode = false;
                      });
                    }
                  },
                  child: Text(
                    "length",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: widthMode ? Colors.green : Colors.white,
                    borderRadius: BorderRadius.circular(4)),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      points = [];
                    });
                    if (!widthMode) {
                      setState(() {
                        widthMode = true;
                        focusMode = lengthMode = false;
                      });
                    } else {
                      setState(() {
                        lengthMode = false;
                        focusMode = widthMode = false;
                      });
                    }
                  },
                  child: Text(
                    "width",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  getWidth() {
    return (pixelRealSize(photoKey, this.widget.imageMicroWidth) *
        _controller.scale!.toDouble() *
        widthPainter.getDistance());
  }

  getLength() {
    return (pixelRealSize(photoKey, this.widget.imageMicroWidth) *
        _controller.scale!.toDouble() *
        lengthPainter.getLength());
  }

  //  Real image Width  /  Container Size  / Image Size


  double pixelRealSize(key, micro) {
    return micro / key.currentContext!.size.width;
  }

  PhotoViewControllerValue getControllerValues() {
    return _controller.value;
  }
}

class WidthPainter extends CustomPainter {
  final Offset p1, p2;

  WidthPainter({required this.p1, required this.p2});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0;

    canvas.drawLine(p1, p2, paint);
    print(p1);
    print(p2);
  }

  double getDistance() {
    return sqrt(pow(p1.dx - p2.dx, 2) + pow(p1.dy - p2.dy, 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  getRealWidth(pixelRealSize) {
    return getDistance() * pixelRealSize;
  }
}

class LengthPainter extends CustomPainter {
  final List<Offset> points;

  LengthPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 3.0;

    canvas.drawPoints(ui.PointMode.polygon, points, paint);
    print(size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double getLength() {
    double sum = 0.0;
    for (int i = 1; i < points.length; i++) {
      sum += sqrt(pow(points[i].dx - points[i - 1].dx, 2) +
          pow(points[i].dy - points[i - 1].dy, 2));
    }
    return sum;
  }

  double getRealLength(pixelRealSize) {
    return getLength() * pixelRealSize;
  }
}

class FocusPainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  FocusPainter({required this.startPoint, required this.endPoint});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    canvas.drawRect(Rect.fromPoints(startPoint, endPoint), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
