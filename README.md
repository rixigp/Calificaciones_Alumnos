Calificaciones Alumnos
=====================

Aplicación web con seguridad creada con el lenguaje Java, que permite a alumnos y profesores la gestión de sus calificaciones.

Se compone de una interfaz en la cual los profesores podrán cargar notas de sus alumnos y visualizar las mismas.

Los alumnos podrán ver sus notas por asignatura y cuatrimestre. 

También existe un usuario administrador que gestiona la base de datos. 

Se han implementado técnicas para mejorar la seguridad de la aplicación web.


Para iniciar la aplicación:

- Cree una base de datos e importe el archivo bbdd.sql a la misma, para importar las tablas y los datos iniciales.

- Se deberá modificar el archivo META-INF/context.xml y colocar la BBDD, usuario y contraseña correspondiente. https://github.com/rixigp/calificacionesAlumnos/blob/a/WebContent/META-INF/context.xml

- Inicie sesión con el usuario administrador: admin/admin

- Tendrá que crear asignaturas, asignándoselas a profesores. No es obligatorio tener profesores creados antes de crear asignaturas, se pueden asignar después.

- Tendrá que crear alumnos y profesores locales si se precisara.

- Añadir libreria: mysql-connector-java-5.1.32-bin.jar a la carpeta de Apache/lib

Cuando un usuario o profesor se conecte mediante LDAP, será candidato a poder ser asignado a cualquier asignatura. El administrador deberá modificar a su LDAP corporativo.

La base de datos, contiene datos cifrados, MD5 para contraseñas de usuarios locales, y DES para asignaturas, nombres de usuarios, mails y tipo de usuarios.

Alumnos

Cuando alumno se ha autenticado mediante LDAP o como local puede llevar a cabo varios tipos de acciones.
- Tendrá la posibilidad de visualizar sus calificaciones por asignatura y por cuatrimestre.
- También tiene la posibilidad de reclamar si cree incorrecta alguna calificación de cualquier asignatura. Pulsando sobre el enlace que aparece debajo de cada asignatura, se abrirá un nuevo correo con su gestor de correos, con los campos ya definidos como serian: el campo Para (con el correo del administrador y del propio alumno), el Asunto y el cuerpo del mensaje.
- Si el alumno tiene acceso local podrá modificar su contraseña (se solicitara la antigua y la nueva dos veces, por seguridad).

Profesores

Una vez que el profesor se ha autenticado mediante LDAP o como local puede llevar a cabo varios tipos de acciones.
- Al mismo modo que los alumnos visualizará las asignaturas a las que fue asignado, dentro de cada asignatura verá el listado de sus alumnos por cuatrimestre (dos preguntas de teoría y un problema).
- Podrá borrar calificaciones de alumnos, no borrar alumnos, ya que esto lo realiza el administrador de la aplicación web.
- También tendrá la responsabilidad de cargar las notas de sus alumnos en formato CSV [18], así como la posibilidad descargarse el listado completo de las mismas. En esta versión de nuestra aplicación para editar notas online, se hará descargando el CSV, modificándolo y volviéndolo a cargar.
- Si el profesor tiene acceso local podrá modificar su contraseña (se solicitara la antigua y la nueva dos veces, por seguridad). 

Administradores

Cuando el administrador se ha autenticado mediante LDAP o como local puede llevar a cabo varios tipos de acciones.
En el panel del administrador tiene diferentes tipos de herramientas para interactuar con la BBDDs:
  
- Creación de usuarios locales: el administrador usara esta herramienta para crear usuarios locales si no dispone de un LDAP corporativo de su empresa.
    
- Creación asignaturas: el administrador usara esta herramienta para crear asignaturas y asignárselas a profesores para que les aparezca en su panel de control. En esta versión de nuestra aplicación solo se puede asignar a un profesor, si se desea ampliar a más de uno, se presupuestara aparte. Se comunicara por email al profesor que se le ha asignado.
    
- Asignar profesores y alumnos a asignaturas: el administrador tendrá la posibilidad de reasignar asignaturas a diferentes profesores mediante un formulario en el que le aparecerán todas las asignaturas disponibles.
    A su vez, también existe un formulario para asignar los alumnos a las asignaturas, se seleccionaran todos los alumnos que correspondan a cada asignatura. Se comunicara por email al profesor que se le ha asignado la asignatura.

- Modificar LDAP: se ha implementado esta herramienta para que se adapte a cualquier LDAP de cualquier centro escolar, y el administrador pueda cambiar los parámetros de la conexión sin tener que acceder a la BBDD.
    
- Reiniciar contraseñas de usuarios: esta función permitirá al administrador reiniciar contraseñas de usuarios, a la contraseña por defecto que será "* login *". Se añadirán asteriscos al principio y al final del login, para dejarla por defecto.


Se presentan algunas restricciones a tener en cuenta a la hora de desplegar la aplicación web. Han de tenerse en consideración a la hora de elegir esta aplicación web.

Administrador

- No podrá agregar nuevos tipos de usuarios al aplicativo.
- No podrá agregar nuevos protocolos de autenticación.
- No podrá cambiar el diseño del aplicativo.
- El correo que se envía nuevos usuarios locales no se podrá modificar personalizar.
- No podrá asignar más de un profesor por asignatura.
 
Profesor

- No podrá eliminar un alumno de su asignatura.
- No podrá cargar calificaciones de alumnos excepto siguiendo el modelo que se tiene de modelo en la página del profesor. No se admitirán archivos que no sean CSV.
- No podrá cargar calificaciones de otra asignatura o profesor.
- Solo se podrán descargar el listado de calificaciones completas por asignatura a carpetas locales de su ordenador.

Alumnos

- Solo podrán visualizar sus propias notas, nunca la de sus compañeros.

Usuarios

- Los usuarios no podrán modificar sus datos a excepción de la contraseña pero solamente los usuarios locales.

