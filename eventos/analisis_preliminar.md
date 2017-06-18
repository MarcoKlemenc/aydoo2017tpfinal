¿Está la documentación/diagramas completos?
En el diagrama de clases no está incluido app.rb.
La carpeta docs posee un archivo de Astah, el cual no debería estar, ya que deben estar exclusivamente las imágenes de los diagramas.
 
¿Está correctamente utilizada la notación UML?
No todas las clases poseen “:” en los diagramas de secuencia.
 
¿Son consistentes los diagramas con el código?
En el diagrama de secuencia de crear calendario no se muestra el parámetro de guardar.
En ambos diagramas de secuencia debería mostrarse la instanciación mediante la función initialize con sus correspondientes parámetros.
La relación entre calendario y evento no debería ser de asociación, ya que, en el dominio del problema, no se contempla la posibilidad de un evento aislado de un calendario.
El diagrama de clases implica que el calendario tiene un repositorio, cuando no es así en el código.
 
¿Implementa toda la funcionalidad pedida?
Al listar eventos no se ven los recurrentes.
No permite un intervalo de exactamente 72 horas (se especificó que no se debe exceder de 72).
No hay eventos recurrentes entre inicio y fin.
El put de eventos permite modificar la recurrencia, lo cual debería estar prohibido.
 
¿Qué observaciones tiene sobre el modelo?
Frecuencias guardadas dentro de app.rb, viola open/closed y single responsibility, ya que tengo que modificar app.rb para agregar o eliminar una.
Todas las clases de frecuencia específica redefinen to_s, pero la redefinición no está incluida en la clase base. Además, la función devuelve el mismo valor para cualquier instancia de una frecuencia.
En app.rb se crea un evento recurrente o uno común dependiendo de una condición; viola open/closed, ya que si agrego otro tipo de evento tengo que agregar otra condición; y single responsibility, ya que app.rb es la encargada tanto de generar el evento como de discernir qué evento generar.
app.rb utiliza la clase JSON, viola open/closed y single responsibility, ya que si se debiera cambiar el formato se tendrá que modificar dicha clase, además dicho comportamiento debería ser responsabilidad de otra clase.
El validador y archivador recibe como parámetro un repositorio de calendarios. Si cambio la forma en la que se almacenan los calendarios tengo que cambiar el validador y archivador también.
Las recurrencias son muy genéricas, solamente especifican un período. No hay forma de agregar condiciones adicionales, como por ejemplo días hábiles.
El evento recurrente redefine el setter de inicio de evento, agregando restricciones a su comportamiento, lo cual viola la sustitución de Liskov.
 
¿Tiene suficiente pruebas?
Posee 58 pruebas, las cuales, según SimpleCov, cubren el 98,29% del código.
Algunos casos muy específicos no están probados (ej. eventos anuales en años bisiestos).
No hay pruebas unitarias de la clase que maneja archivos.
Los to_s de las frecuencias no tienen pruebas.
 
¿Qué cambios deben realizarse?
Agregar app.rb en el diagrama de clases.
Eliminar la dependencia de repositorio en validador y archivador.
Extraer la funcionalidad de JSON a una clase aparte.
Eliminar la lógica en app.rb que crea un evento recurrente o común dependiendo de si la entrada tiene recurrencia o no.
Transferir la responsabilidad del mapeo de frecuencias a otra clase.
Buscar una forma flexible de crear el evento apropiado.
Crear una clase para modelar el recurso.
Crear un repositorio de recursos.
Permitir que el evento pueda almacenar un recurso y que el recurso esté asociado a un evento.
Agregar la lógica para interpretar los requests de recursos.
Extender la escritura y lectura de archivos para que incluya los recursos.
