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
class ImageBoxDragDrop extends Sprite {

  bool touchIsSupported;
  Sprite imageTarget = new Sprite();
  Sprite imageLayer;
  Sprite _imageBoxGraphics;
  TextField _infoText;
  String _textString;
  CheckBox _check;

  static const int _numberOfImages = 6;
  static const int _imageBoxX = 0;
  static const int _imageBoxY = 35;
  static const int _imageBoxWidth = 700;
  static const int _imageBoxHeight = 140;
  static const int _imageWidth = 104;
  static const int _imageHeight = 80;
  static const int _gap = 3;

  static const String TOUCH_EVENTS_TEXT_STRING = 'touch events without GlassPlate    [ last selected image = ';
  static const String MOUSE_EVENTS_TEXT_STRING = 'mouse events with startdrag & stopdrag    [ last selected image = ';

  List _colorList = [0xFF940A2D, 0xFFD94600, 0xFFFF8000, 0xFFFEF04B, 0xFF008080, 0xFFA6A600];
  Rectangle _boundsRect = new Rectangle(_imageWidth / 2, _imageHeight / 2, _imageBoxWidth - _imageWidth, _imageBoxHeight - _imageHeight);
  Rectangle imageBoxRect = new Rectangle(_imageBoxX, _imageBoxY, _imageBoxWidth, _imageBoxHeight);


  ImageBoxDragDrop(bool touchSupported) {
    touchIsSupported = touchSupported;
    _init();
  }

  void _init() {
    _drawImageBoxGraphics();
    _drawImageLayerAndFillWithImages();
    initListenersAndInfoTexts();
  }

  void _drawImageBoxGraphics() {
    _imageBoxGraphics = new Sprite()
      ..x = _imageBoxX
      ..y = _imageBoxY
      ..addTo(this)
      ..graphics.beginPath()
      ..graphics.rect(0, 0, _imageBoxWidth, _imageBoxHeight)
      ..graphics.fillColor(Color.Black)
      ..graphics.strokeColor(Color.White, 2)
      ..graphics.closePath()
      ..applyCache(-1, -1, _imageBoxWidth + 2, _imageBoxHeight + 2);
  }

  void _drawImageLayerAndFillWithImages() {
    imageLayer = new Sprite()
      ..x = _imageBoxX
      ..y = _imageBoxY
      ..addTo(this);

    /// fill the imageLayer with rectangular shaped images, each with a number
    int offset = 30;
    for (int i = 0; i < _numberOfImages; i++) {
      Sprite image = _drawColoredAndNumberedImage(i)
      /// for a bigger number of images, the images are drawn in rows of 10 images with a gap between the rows
        ..x = offset + (i % 6) * (_imageWidth + _gap)
        ..y = offset
        ..addTo(imageLayer);
    }
  }

  void initListenersAndInfoTexts() {
    if (touchIsSupported) {
      _addTouchListeners();
      drawImageBoxInfoTextField(TOUCH_EVENTS_TEXT_STRING);
      drawCheckBoxTouchOutEvents();
    } else {
      _addMouseListeners();
      drawImageBoxInfoTextField(MOUSE_EVENTS_TEXT_STRING);
    }
  }

  void drawImageBoxInfoTextField(String textString) {
    _textString = textString;
    TextFormat textFormat = new TextFormat('Helvetica,Arial', 18, Color.White);
    textFormat.align = "left";
    _infoText = new TextField()
      ..defaultTextFormat = textFormat
      ..y = 8
      ..width = _imageBoxWidth
      ..height = 30
      ..addTo(this)
      ..text = '${_textString} none ]';
  }

  void drawCheckBoxTouchOutEvents() {
    _check = new CheckBox("  TouchOut events")
      ..x = 530
      ..y = 8
      ..on(Event.CHANGE).listen(onCheckChanged)
      ..addTo(this);
  }

  Sprite _drawColoredAndNumberedImage(int index) {
    Sprite image = new Sprite()
      ..name = index.toString();

    Rectangle rectangle = new Rectangle(0, 0, _imageWidth, _imageHeight);
    int imageColor = _colorList[index % _colorList.length];

    BitmapData bitmapData = new BitmapData(_imageWidth, _imageHeight)
      ..fillRect(rectangle, imageColor);
    Bitmap bitmap = new Bitmap(bitmapData)
      ..addTo(image);
    TextFormat textFormat = new TextFormat('Helvetica,Arial', 18, Color.Black);
    textFormat.align = "left";
    textFormat.leftMargin = 10;
    textFormat.topMargin = 5;
    TextField textField = new TextField()
      ..addTo(image)
      ..defaultTextFormat = textFormat
      ..mouseEnabled = false
      ..width = _imageWidth
      ..height = _imageHeight
      ..text = index.toString();
    return image;
  }

  void _addTouchListeners() {
    imageLayer.onTouchBegin.listen(_inputEventDownHandler);
    imageLayer.onTouchEnd.listen(inputEventUpHandler);

    /// the TouchOut eventListener is on by default but can be switched off
    imageLayer.onTouchOut.listen(inputEventUpHandler);
  }

  void _addMouseListeners() {
    imageLayer.onMouseDown.listen(_inputEventDownHandler);
    imageLayer.onMouseUp.listen(inputEventUpHandler);

    /// the MouseOut eventListener
    imageLayer.onMouseOut.listen(inputEventUpHandler);
  }

  void _showLastClickedImageInfo(String info) {
    _infoText.text = '${_textString + info} ]';
  }

  void _inputEventDownHandler(InputEvent ie) {
    imageTarget = ie.target as Sprite;
    if (imageTarget != imageLayer) startDragImage();
  }

  void startDragImage() {
    ///set the target on the image that lies on top
    imageLayer.setChildIndex(imageTarget, imageLayer.numChildren - 1);
    _showLastClickedImageInfo(imageTarget.name);
    imageTarget.startDrag(true, _boundsRect);
  }

  void inputEventUpHandler(InputEvent ie) {
    imageTarget.stopDrag();
  }

  void onCheckChanged(Event e) {
    var cb = e.target as CheckBox;
    if (!cb.state) {
      imageLayer.removeEventListener(TouchEvent.TOUCH_OUT, inputEventUpHandler);
    } else {
      imageLayer.addEventListener(TouchEvent.TOUCH_OUT, inputEventUpHandler);
    }
  }

}
