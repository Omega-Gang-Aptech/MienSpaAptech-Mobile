// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mien_spa_mobile/global_component/image_container.dart';

import 'package:mien_spa_mobile/theme/constants.dart';

class HeroImage extends StatefulWidget {
  const HeroImage({
    Key? key,
    required this.tag,
    this.child,
    required this.launchPhoto,
  }) : super(key: key);

  final String tag;

  final Widget? child;
  final String launchPhoto;

  @override
  State<HeroImage> createState() => _HeroImageState();
}

class _HeroImageState extends State<HeroImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute<void>(builder: (BuildContext context) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: KBlack,
              body: Stack(children: [
                IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: KWhite,
                    )),
                Center(
                    child: SizedBox(
                  width: double.infinity,
                  child: Hero(
                      tag: widget.tag,
                      child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            child: DoubleTappableInteractiveViewer(
                              scaleDuration: const Duration(milliseconds: 600),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: ImageContainer(
                                    imageUrl: widget.launchPhoto,
                                    width: double.infinity,
                                    height: 350,
                                    borderRadius: 0,
                                    boxfit: BoxFit.cover),
                              ),
                            ),
                          ))),
                )),
              ]),
            ),
          );
        }));
      },
      child: widget.child,
    );
  }
}

class DoubleTappableInteractiveViewer extends StatefulWidget {
  final double scale;
  final Duration scaleDuration;
  final Curve curve;
  final Widget child;

  const DoubleTappableInteractiveViewer({
    super.key,
    this.scale = 3,
    this.curve = Curves.fastLinearToSlowEaseIn,
    required this.scaleDuration,
    required this.child,
  });

  @override
  State<DoubleTappableInteractiveViewer> createState() =>
      _DoubleTappableInteractiveViewerState();
}

class _DoubleTappableInteractiveViewerState
    extends State<DoubleTappableInteractiveViewer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<Matrix4>? _zoomAnimation;
  late TransformationController _transformationController;
  TapDownDetails? _doubleTapDetails;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.scaleDuration,
    )..addListener(() {
        _transformationController.value = _zoomAnimation!.value;
      });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    final newValue = _transformationController.value.isIdentity()
        ? _applyZoom()
        : _revertZoom();

    _zoomAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: newValue,
    ).animate(CurveTween(curve: widget.curve).animate(_animationController));
    _animationController.forward(from: 0);
  }

  Matrix4 _applyZoom() {
    final tapPosition = _doubleTapDetails!.localPosition;
    final translationCorrection = widget.scale - 1;
    final zoomed = Matrix4.identity()
      ..translate(
        -tapPosition.dx * translationCorrection,
        -tapPosition.dy * translationCorrection,
      )
      ..scale(widget.scale);
    return zoomed;
  }

  Matrix4 _revertZoom() => Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: _handleDoubleTapDown,
      onDoubleTap: _handleDoubleTap,
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 4,
        panEnabled: true,
        scaleEnabled: true,
        transformationController: _transformationController,
        child: widget.child,
      ),
    );
  }
}
