library drag_and_drop;

import 'package:stagexl/stagexl.dart';
import 'dart:html' as html;

part 'source/image_box_drag_drop.dart';
part 'source/image_box_drag_drop_glassplate.dart';
part 'source/check_box.dart';


Stage stage;
RenderLoop renderLoop;
ImageBoxDragDrop imageBoxDragDrop;
ImageBoxDragDropGlassPlate imageBoxDragDropGlassPlate;
bool touchIsSupported = false;
TextField introText;

/**
 * StageXL GlassPlate Example 2015
 *
 * Any portion of this example may be reused for any purpose where not licensed
 * by another party restricting such use. Please leave the credits intact.
 *
 * author Arjen Wassenaar   riamore.com
 * link: http://www.riamore.com/dart/stagexl/glassplate_example/drag_and_drop/index.html
 *
 */
main() async {


  /// configure StageXL default options.
  /// StageXL 0.12 Stage Constructor
  StageXL.stageOptions.renderEngine = RenderEngine.WebGL;
  if (StageXL.environment.isTouchEventSupported == true) {
    StageXL.stageOptions.stageScaleMode = StageScaleMode.SHOW_ALL;
    StageXL.stageOptions.stageAlign = StageAlign.NONE;
    touchIsSupported = true;
  }
  else {
    StageXL.stageOptions.stageScaleMode = StageScaleMode.NO_SCALE;
    StageXL.stageOptions.stageAlign = StageAlign.TOP_LEFT;
  }

  StageXL.stageOptions.inputEventMode = InputEventMode.MouseAndTouch;
  StageXL.stageOptions.backgroundColor = 0xFF666666;

  Stage stage = new Stage(html.querySelector('#stage'), width: 800, height: 430);

  renderLoop = new RenderLoop();
  renderLoop.addStage(stage);


  TextFormat textFormat = new TextFormat('Helvetica,Arial', 18, Color.White);
  introText = new TextField()
    ..defaultTextFormat = textFormat
    ..textColor = Color.White
    ..multiline = true
    ..width = 700
    ..x = 50
    ..y = 10
    ..addTo(stage);


  /// measure the fps
  num _fpsAverage = null;
  stage.onEnterFrame.listen((EnterFrameEvent e) {
    if (_fpsAverage == null) {
      _fpsAverage = 1.00 / e.passedTime;
    } else {
      _fpsAverage = 0.05 / e.passedTime + 0.95 * _fpsAverage;
    }
    introText.text = 'StageXL for Dart  - drag & drop example for desktop / mobile\n[ current render engine: ${stage.renderEngine}   fps: ${_fpsAverage.round()} ]';
  });

  imageBoxDragDrop = new ImageBoxDragDrop(touchIsSupported)
    ..addTo(stage)
    ..x = 50
    ..y = 55;

  imageBoxDragDropGlassPlate = new ImageBoxDragDropGlassPlate(touchIsSupported)
    ..addTo(stage)
    ..x = 50
    ..y = 235;

}
