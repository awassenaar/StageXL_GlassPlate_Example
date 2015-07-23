part of drag_and_drop;

class CheckBox extends Sprite {

  bool state = true;
  Sprite _checkBoxShape;
  TextField _textField;

  CheckBox(String cbLabel) : super() {

    var textFormat = new TextFormat('Helvetica,Arial', 18, Color.White);
    textFormat.align = TextFormatAlign.RIGHT;
    textFormat.leftMargin = 5;
    textFormat.rightMargin = 5;

    _checkBoxShape = new Sprite();
    _checkBoxShape.addTo(this);
    _drawCheckBoxGraphics();

    _textField = new TextField();
    _textField.defaultTextFormat = textFormat;
    _textField.width = 175;
    _textField.height = 22;
    _textField.text = cbLabel;
    _textField.wordWrap = true;
    _textField.mouseEnabled = false;
    _textField.addTo(this);


    this.onMouseDown.listen(_toggleState);
    this.onTouchBegin.listen(_toggleState);
  }

  void _drawCheckBoxGraphics() {
    _checkBoxShape.graphics.beginPath();
    _checkBoxShape.graphics.rect(5, 0, 20, 22);
    if (state) {
      _checkBoxShape.graphics.moveTo(10, 5);
      _checkBoxShape.graphics.lineTo(20, 17);
      _checkBoxShape.graphics.moveTo(20, 5);
      _checkBoxShape.graphics.lineTo(10, 17);
    }
    _checkBoxShape.graphics.closePath();
    _checkBoxShape.graphics.fillColor(Color.Black);
    _checkBoxShape.graphics.strokeColor(Color.White, 2);
    _checkBoxShape.applyCache(4, -1, 27, 24);

  }

  void _toggleState(e) {
    state = !state;
    _drawCheckBoxGraphics();
    this.dispatchEvent(new Event(Event.CHANGE));
  }
}
