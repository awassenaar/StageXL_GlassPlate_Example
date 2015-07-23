# StageXL GlassPlate Example
A drag & drop example that demonstrates the StageXL GlassPlate
(StageXL is a fast and universal 2D rendering engine for HTML5 written in Dart)

## Live example
link: http://www.riamore.com/dart/stagexl/glassplate_example/drag_and_drop/index.html

## StageXL GlassPlate

The GlassPlate definition from the StageXL API reference:

"An invisible and rectangular display object to catch input events.

You can use the GlassPlate to cover up other display objects to catch
all interactive inputs like mouse and touch inputs. This is useful if
the covered display objects has an undetermined size but you need a
rectangular hit area. It may also improve the performance if you cover
many display objects with one GlassPlate, this way the engine does not
need to check for hits on the covered display objects."

## About the drag & drop example

The example shows two imageboxes each containing 5 images that can be dragged & dropped
within the bounds of their imagebox.
The upper imagebox uses the parent sprite of the images to handle mouse and touch inputs,
the lower one uses the StageXl GlassPlate.

The example demonstrates that the GlassPlate handles fast dragging better on touch-enabled devices
when touchOut events are needed (bounds);
In the case that the parent sprite of the images handles the touchOut events, fast dragging also fires
touchOut events as soon as the dragged image lags behind the point where the screen is touched.
This causes the dragging to end.
