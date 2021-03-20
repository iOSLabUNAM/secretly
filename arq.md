## Arquitecture

- Modelos
  - User
  - Post
  - Comment
- Vistas / Controllers
  - Vista de feed
    - Preloading (infinite scroll)
  - Single post: DRY
  - Vista de coment
  - Creacion de post (validaciones -> Combine?)
  - Creacion de comment (validaciones???)

- Network layer (fault tolerant <Result type>, codable)
- Persitencia de datos en disco
  - Credenciales seguras(keychain)
  - Manejo de cache
- Geolocation
  - Obtener lat-long por sensores
  - Envia en request de post
- Modulo de seguridad
  - Obtener y enviar un identificador de dispositivo unico
  - Bloquear acciones de usuario si ha sido bloqueado (403)
- Image processing
  - Access to camera or lib
  - Take pictures
  - Send image over the wire
  - Aplicarle filtro de blur gausiano
