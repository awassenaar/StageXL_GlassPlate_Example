part of drag_and_drop;

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
class ImageBoxDragDropGlassPlate extends ImageBoxDragDrop {
  GlassPlate _glassPlate;

  static const String GLASSPLATE_TOUCH_EVENTS_TEXT_STRING = 'touch events with GlassPlate    [ last selected image = ';
  static const String GLASSPLATE_MOUSE_EVENTS_TEXT_STRING = 'mouse events with GlassPlate    [ last selected image = ';

  ImageBoxDragDropGlassPlate(touchIsSupported) : super(touchIsSupported) {
  }

  @override
  void initListenersAndInfoTexts() {
    _initGlassPlate();
    if (super.touchIsSupported) {
      _addGlassPlateTouchListeners();
      super.drawImageBoxInfoTextField(GLASSPLATE_TOUCH_EVENTS_TEXT_STRING);
      super.drawCheckBoxTouchOutEvents();
    } else {
      _addGlassPlateMouseListeners();
      super.drawImageBoxInfoTextField(GLASSPLATE_MOUSE_EVENTS_TEXT_STRING);
    }
  }

  void _initGlassPlate() {
    Rectangle rect = super.imageBoxRect;
    _glassPlate = new GlassPlate(rect.width, rect.height)
      ..addTo(this)
      ..x = rect.left
      ..y = rect.top;
  }

  void _addGlassPlateTouchListeners() {
    _glassPlate.onTouchBegin.listen(_inputEventDownGlassPlateHandler);
    _glassPlate.onTouchEnd.listen(super.inputEventUpHandler);

    /// the TouchOut eventListener is on by default but can be switched off
    _glassPlate.onTouchOut.listen(super.inputEventUpHandler);
  }

  void _addGlassPlateMouseListeners() {
    _initGlassPlate();
    _glassPlate.onMouseDown.listen(_inputEventDownGlassPlateHandler);
    _glassPlate.onMouseUp.listen(super.inputEventUpHandler);

    /// the MouseOut eventListener
    _glassPlate.onMouseOut.listen(super.inputEventUpHandler);
  }

  void _inputEventDownGlassPlateHandler(InputEvent ie) {
    int nc = super.imageLayer.numChildren;
    int hit = -1;

    /// find the image that corresponds with the x and y coordinates
    /// if more than one image corresponds to these coordinates, get the last one (is the one on top)
    for (int i = 0; i < nc; i++) {
      if (super.imageLayer.getChildAt(i).hitTestPoint(ie.stageX, ie.stageY, true)) hit = i;
    }
    if (hit != -1) {
      super.imageTarget = super.imageLayer.getChildAt(hit);
      super.startDragImage();
    }
  }

  @override
  void onCheckChanged(Event e) {
    var cb = e.target as CheckBox;
    if (!cb.state) {
      _glassPlate.removeEventListener(TouchEvent.TOUCH_OUT, super.inputEventUpHandler);
    } else {
      _glassPlate.addEventListener(TouchEvent.TOUCH_OUT, super.inputEventUpHandler);
    }
  }

}
