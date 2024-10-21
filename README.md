# Proyecto de Mantenimiento de Autos

## Descripción
Este proyecto es una aplicación para gestionar autos y los servicios de mantenimiento asociados, implementada en Ruby on Rails. Utilizamos las siguientes versiones:

- **Ruby**: 3.2.2
- **Rails**: 7.2.1.1

Este README te guiará paso a paso para instalar y poner en funcionamiento el proyecto en tu entorno local.

## Requisitos previos
Asegúrate de tener instalados los siguientes componentes:

- Ruby 3.2.2
- Rails 7.2.1.1
- PostgreSQL
- Node.js y Yarn

## Instalación

Sigue estos pasos para instalar y ejecutar el proyecto:

### 1. Clonar el repositorio
Clona este repositorio a tu máquina local usando el siguiente comando:

```sh
$ git clone [[URL del repositorio]](https://github.com/carlozdaniel/mantenimiento_autos.git)
$ cd mantenimiento_autos
```

### 2. Instalar las dependencias
Ejecuta el siguiente comando para instalar todas las gemas necesarias:

```sh
$ bundle install
```

### 3. Configurar la base de datos
Crea y migra la base de datos utilizando los siguientes comandos:

```sh
$ rails db:create
$ rails db:migrate
```

### 4. Cargar los datos iniciales (seed)
Si necesitas cargar datos iniciales en la base de datos, ejecuta:

```sh
$ rails db:seed
```

### 5. Iniciar el servidor
Para iniciar el servidor local, usa el siguiente comando:

```sh
$ rails server
```
El servidor estará disponible en [http://localhost:3000](http://localhost:3000).

## Pruebas
El proyecto utiliza **RSpec** para las pruebas. Puedes ejecutar todas las pruebas con el siguiente comando:

```sh
$ bundle exec rspec
```

## Autenticación
Este proyecto utiliza **Devise** para la autenticación de usuarios y **Devise-JWT** para autenticación basada en tokens.

## Rutas de la API
Las rutas principales para la gestión de autos y servicios de mantenimiento están disponibles en la versión 1 de la API. Algunos ejemplos incluyen:

- **Obtener todos los autos**:
  - **GET** `/api/v1/cars`
- **Crear un auto**:
  - **POST** `/api/v1/cars`
- **Mostrar un auto específico**:
  - **GET** `/api/v1/cars/:id`
- **Actualizar un auto**:
  - **PUT** `/api/v1/cars/:id`
- **Eliminar un auto**:
  - **DELETE** `/api/v1/cars/:id`
- **Obtener servicios de mantenimiento de un auto**:
  - **GET** `/api/v1/cars/:car_id/maintenance_services`

Puedes usar herramientas como **Postman** para probar estas rutas.

## Ejemplo de uso en Postman
Para realizar una solicitud **POST** a la API para crear un nuevo auto, puedes utilizar la siguiente configuración en **Postman**:

- **URL**: `http://localhost:3000/api/v1/cars`
- **Método**: `POST`
- **Cuerpo**: (formato JSON)
  ```json
  {
    "car": {
      "make": "Toyota",
      "model": "Corolla",
      "year": 2020
    }
  }
  ```

## Contacto
Para más información, puedes visitar mi perfil en:
- [LinkedIn](https://www.linkedin.com/in/cadahr/)
- [Mi portafolio personal](https://carlozdaniel.github.io/carlos-cv/)

 Si tienes alguna duda o sugerencia, no dudes en contactarme.

