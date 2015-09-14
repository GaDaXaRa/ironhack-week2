* Crear un BaseViewController con toda la lógica de añadir elmentos unos debajo de otros

* Hacer que nuestro viewController principal extienda del BaseViewController

* Crear otro viewController para la selección de la foto. Llevará un imageView para mostrar la foto seleccionada, un Picker para elegir el nombre de la foto. Y un botón para hacer dismiss.

* Dentro de este nuevo viewcontroller vamos a conformar los protocolos de delegado y datasource del picker.

* Cuando se seleccione uno de los nombres de imagen. Poner la imagen en el imageView y enviar una notificación de que se ha seleccionado una nueva imagen.

* El botón de este viewController sólo hace dismiss del mismo

* En el viewController principal: Poner un boton para presentar el nuevo viewController

* Apuntarse a la notificación para cambiar la imagen. La imagen la pondremos directamente en el botón.


