export function saveCanvas(app) {
  const canvasController = app.getControllerForElementAndIdentifier(
    document.querySelector('[data-controller~="canvas"]'),
    "canvas"
  )
  if (canvasController) canvasController.save()
}
