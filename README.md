# Challenge Flutter
## Introducción
Crear una aplicación en Flutter bien simple que consuma la API JsonPlaceholder (presentada a continuación).
La idea de este challenge es evaluar tus buenas prácticas de desarrollo y conocimientos en el framework. No se evaluará diseño.

## Api
[API](https://jsonplaceholder.typicode.com/)
[API Guide](https://jsonplaceholder.typicode.com/guide/)

## Requerimientos

- La app tiene que poseer 3 páginas:
    1. Una pantalla de Login inicial. El login tiene que ser simulado (sin usar autenticación contra servidor, solamente setear una variable como isAuthenticated en true). Una vez logueado, tiene que haber una pantalla donde se puedan ver todos los posts.
    2. Esta primera pantalla luego del login debe listar todos los posts. Tiene que tener un botón de creación de posts (FloatingActionButton). Y una barra de búsqueda superior.
    3. La barra de búsqueda debe permitir buscar los posts por nombre del usuario, es decir, si se busca ‘Leanne Graham’ (cuyo id de usuario es 1) me tienen que aparecer todos los posts con userId igual a 1.

- La app debe de poder manejar estar sin conexión (que si la API no responde y timeoutea, se pueda seguir accediendo a la información que se trajo previamente). Como opcional, se podría mostrar un toast/snackbar si no hay conexión o si falla la API.
- El login deberá de solo habilitar un usuario y contraseña: `challenge@fudo / password` . Cualquier otra combinación de usuario/contraseña debe fallar.
- Manejo de errores: si se ingresa usuario y contraseña inválidos, debe mostrar un toast/snackbar con la información del error.
- Subir a Gitlab/Github publico con instrucciones para correrlo junto con un APK.
    - Nota: en lo posible, el repositorio debe contener la historia de los commits

Eso es todo, ¡gracias!

# Resolución

## Tareas
  - [x] Crear la app con 3 páginas (login, posts, busqueda)
  - [x] es capaz de filtrar los posts por usuario (auto completar + historirial de busqueda)
  - [x] Puede manejarse sin internet, accesdiendo a datos cargados anteriormente
  - [x] Muestra cuando no hay acceso a internet
  - [x] Puede manejar un usuario y contraseña inválidos
  - [x] Unica combinación de usuario/contraseña: `challenge@fudo / password`
  - [x] La app contiene manejo de errores
  - [ ] Unit tests

## instrucciones de uso

1. Instala Flutter en tu equipo.
2. Ejecuta el comando `flutter run` en la carpeta `challenge_flutter` para ejecutar la aplicación o abrir debugger, en vscode hay una configuracion para correr el proyecto (.vscode/launch.json).

