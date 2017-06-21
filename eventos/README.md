__Decisiones de diseño sobre funcionalidad nueva:__
* El recurso sabe en qué intervalos de tiempo no estará disponible.
* El recurso no sabe qué evento lo utilizará en cierto intervalo.
* Al dar de alta un evento con recurso asignado, el mismo se reserva inmediatamente.
* Para un evento recurrente, la reserva se realiza en todos los intervalos.
* Si en un put no se especifica un recurso, se mantendrá el actual (si hay) o no se asignará ninguno.

__Decisiones de diseño sobre funcionalidad anterior:__
* Se utiliza Chain of Responsibility para crear el evento adecuado (común o recurrente).
* Se crea una clase que almacena todas las frecuencias mapeadas a strings.
* Se generaliza el uso del archivador para que el mismo no esté restringido a calendarios.
* El validador recibe una lista de calendarios en lugar de un repositorio.
* Se crea una clase que se encarga de transformar hash en JSON y viceversa.
