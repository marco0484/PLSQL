ORACLE APEX

Oracle APEX (Oracle Application Express) es una plataforma low code que permite crear aplicaciones web y móviles directamente sobre una base de datos Oracle Database. 
Low code significa que se pueden construir aplicaciones con poco código escrito manualmente, utilizando asistentes, componentes visuales y configuraciones declarativas.

APEX vive completamente en la web. Su IDE (Integrated Development Environment) está en línea, por lo que no es necesario instalar nada en la computadora para desarrollar. 
Solo se necesita un navegador. 
Puede estar alojado en Oracle Cloud, en un servidor empresarial o en un entorno local. Funciona mediante Oracle REST Data Services (ORDS), que actúa como puente entre el navegador y la base de datos.

El ciclo de trabajo en APEX normalmente sigue tres etapas: 
1. Desarrollar (crear páginas, lógica y reportes)
2. Personalizar (configurar seguridad, interfaz y validaciones) 
3. Entregar o desplegar la aplicación para los usuarios finales.

Al ingresar a APEX se encuentran cuatro módulos principales: 
1. App Builder (donde se crean las aplicaciones)
2. SQL Workshop (para ejecutar consultas, crear tablas, vistas y objetos PL/SQL)
3. Team Development (para gestión de tareas y seguimiento) 
4. Gallery (ejemplos y aplicaciones preconfiguradas).

Existen diferentes tipos de usuarios: 
1. Instance Administrator (administra toda la instancia)
2. Workspace Administrator (administra un espacio de trabajo específico)
3. Developer (construye aplicaciones) y End User (usa la aplicación final).

Entre las utilidades de APEX están: 
1. crear y ejecutar consultas SQL
2. cargar y descargar datos
3. generar DDL
4. administrar configuraciones de interfaz
5. monitorear actividad de base de datos 
6. administrar usuarios.

Los elementos principales de una página en APEX incluyen 
1. botones
2. regiones (contenedores de contenido)
3. items como Select List o campos de texto
4. páginas tipo Modal Dialog (ventanas emergentes)
5. Drawer (panel lateral deslizable) 
6. páginas normales de pantalla completa.

En cuanto a componentes de datos:
1. Interactive Grid permite insertar, actualizar y eliminar registros directamente sin necesidad de un formulario adicional
2. Interactive Report permite filtrar, ordenar y exportar datos, pero normalmente requiere un formulario aparte para editar registros.
3. La búsqueda por facetas (Faceted Search) permite aplicar filtros dinámicos sobre grandes volúmenes de datos, similar a los filtros de un e-commerce.

Dentro de SQL Workshop, en Utilities → Data Workshop, se pueden cargar archivos como XLS o CSV y convertirlos en tablas, ajustando previamente los tipos de datos. Es muy útil para prototipos rápidos o migraciones simples.

Una aplicación APEX puede configurarse como PWA (Progressive Web App), lo que permite instalarla como si fuera una aplicación móvil y usarla en pantalla completa. Para que funcione como PWA debe estar servida en HTTPS o en un entorno local seguro; en entornos no seguros las funciones PWA no se habilitan.

Los pasos básicos para crear una página son: crear la página, seleccionar la fuente de datos (tabla, vista o consulta), elegir el tipo de componente (reporte, formulario, gráfico o grid) y configurar sus atributos y seguridad.

Cuando se genera una aplicación basada en una tabla, APEX normalmente crea tres páginas por defecto: un reporte, un formulario y una página de navegación. Esto responde al patrón clásico Report → Form → Process, que permite visualizar, editar y procesar datos. Si se activan todas las features al crear la aplicación, APEX agrega funcionalidades adicionales como autenticación, control de acceso, reporte de actividad, feedback, cambio de tema y configuración PWA. Cada feature es un módulo listo para usar que añade capacidades empresariales sin desarrollo adicional.

La arquitectura de APEX funciona así: el usuario entra desde el navegador, ORDS recibe la petición, consulta la base de datos, ejecuta la lógica PL/SQL dentro de la base y genera HTML dinámicamente que se envía al navegador. En APEX no existe un backend separado como en arquitecturas tradicionales; la lógica vive directamente en la base de datos.

Los tipos de página se utilizan según el caso: 
1. Una página normal se usa para contenido principal completo
2. Un Modal Dialog se utiliza para capturar o editar información sin salir de la página actual
3. Un Drawer se utiliza cuando se quiere una experiencia más moderna con panel lateral sin interrumpir completamente el flujo del usuario.

En resumen, Oracle APEX permite desarrollar aplicaciones empresariales rápidamente, aprovechando la potencia de Oracle Database, reduciendo el código manual y acelerando el tiempo de entrega sin perder capacidades avanzadas de seguridad, rendimiento y escalabilidad.

Datos de prueba:
SQL Workshop > Sample Datasets           -> datos de prueba
SQL Workshop > Utilities > Data Workshop -> Cargar datos desde xls, se pueden validar
SQL Workshop > SQL Object browser        -> Buscar los objetos en la base de datos y editar sus propiedades
Quick SQL                                -> Subes tus scripts y se ejecutan todos al mismo timepo y se muestran los errores en caso de que ocurra uno