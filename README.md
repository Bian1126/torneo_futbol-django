# Tutorial: Despliegue del Proyecto "Torneo de Fútbol" en Django con Docker

Práctico de Mapeo Objeto-Relacional para la materia **Bases de Datos** de la carrera **Ingeniería en Sistemas**  
Universidad Tecnológica Nacional - Facultad Regional Villa María

---

## Tecnologías utilizadas

* Docker + Docker Compose  
* Django 5.1.11  
* Python 3.13  
* PostgreSQL 17  
* Alpine Linux  

---

## Mantenido por Grupo 03 - Integrantes:

* Bergas, Victoria  
* Corti, Elba  
* Giovanardi Blanco, Felipe  
* Lattanzi, Simona  
* Peliza, Matías  
* Petrucci, Bianca  
* Porporatto, Lázaro  
* Rubio Falcon, Carolina Inés  

---

## Descargo de Responsabilidad

El código proporcionado se ofrece "tal cual", sin garantía de ningún tipo, expresa o implícita.  
En ningún caso los autores o titulares de derechos de autor serán responsables de cualquier reclamo, daño u otra responsabilidad.

---

## Introducción

Este proyecto tiene como objetivo modelar y desplegar un sistema de gestión para **torneos de fútbol**.  
A través del mismo se representan equipos, jugadores, partidos, canchas y categorías, con el fin de aplicar conceptos de mapeo objeto-relacional, relaciones entre entidades, migraciones y carga de datos iniciales.

---

## Requisitos Previos

* Docker y Docker Compose instalados en tu sistema. Puedes consultar la [documentación oficial de Docker](https://docs.docker.com/get-started/get-docker/) para la instalación.
* Conocimientos básicos de Django y Python (no excluyente, el tutorial es autoexplicativo).

### Recursos Útiles

* [Tutorial oficial de Django](https://docs.djangoproject.com/en/2.0/intro/tutorial01/)
* [Cómo crear un entorno en Python](https://docs.djangoproject.com/en/2.0/intro/contributing/)

---

## Instrucciones de cómo levantar el proyecto

### 1. Clonar el repositorio
> Puedes copiar todo este bloque y pegarlo directamente en tu terminal.
```bash
git clone https://github.com/Bian1126/torneo_futbol-django.git
```

### 2. Configuración de Variables de Entorno
En el archivo `.env.db` utilizado para almacenar las variables de entorno necesarias para la conexión a la base de datos, configúralo de la siguiente manera:  
>Puedes copiar todo este bloque y pegarlo directamente en tu archivo `.env.db`.
```dotenv
# .env.db
# .env.db
DATABASE_ENGINE=django.db.backends.postgresql
POSTGRES_HOST=db
POSTGRES_PORT=5432
POSTGRES_DB=torneo-futbol
POSTGRES_USER=postgres
PGUSER=${POSTGRES_USER}
POSTGRES_PASSWORD=postgres
LANG=es_AR.utf8
POSTGRES_INITDB_ARGS="--locale-provider=icu --icu-locale=es-AR --auth-local=trust"

```

### 3. Levantar el proyecto
> **Nota:**  
> Si es la primera vez que se levanta el proyecto, desde la terminal ingresa el siguiente comando:

**Windows**
```bash
./init.ps1
```

**Linux**
```bash
. init.sh
```

> **Importante:**  
> En caso de que ya lo hayas levantado previamente, solo levanta el contenedor:

```bash
docker compose up -d backend
```

### 4. Acceso a Torneo
[http://localhost:8000/admin/login/?next=/admin/](http://localhost:8000/admin/login/?next=/admin/)

---

## 🔐 Acceso a la Administración de Django

* **Usuario:** `admin`  
* **Contraseña:** `admin`

---

## Servicios Definidos en Docker Compose

### 1. **db**
> Contenedor de PostgreSQL.

* Imagen: `postgres:alpine`  
* Volumen persistente: `postgres-db`  
* Variables de entorno: definidas en `.env.db`  
* Healthcheck incluido (espera a que el servicio esté listo)

### 2. **backend**
> Servidor de desarrollo Django.

* Comando: `python3 manage.py runserver 0.0.0.0:8000`  
* Puerto expuesto: `8000`  
* Código montado desde `./src`  
* Depende de: `db` (espera a que esté saludable)

### 3. **generate**
> Servicio opcional para crear el proyecto Django si no existe.

* Ejecuta: `django-admin startproject app src`  
* Útil al iniciar el proyecto por primera vez  
* Usa permisos de root para crear carpetas

### 4. **manage**
> Ejecuta comandos `manage.py` desde Docker.

* Entrypoint: `python3 manage.py`  
* Ideal para migraciones, superusuario, etc.

---

## Estructura del Proyecto

```
TORNEO-FUTBOL/
├── src/
│   └── app/                  # Proyecto Django principal
│       ├── torneo/           # Aplicación principal "torneo"
│       │   ├── fixtures/     # Datos de ejemplo
│       │   │   └── initial_data.json
│       │   ├── migrations/   # Migraciones de base de datos
│       │   ├── __init__.py
│       │   ├── admin.py      # Registro de modelos en el panel de administración
│       │   ├── apps.py       # Configuración de la app
│       │   ├── models.py     # Definición de modelos (estructura de la BD)
│       │   ├── views.py      # Vistas (lógica del backend)
│       │   ├── tests.py      # Pruebas automáticas
│       └── manage.py         # Herramienta CLI de Django
├── .env.db                   # Variables de entorno de la base de datos
├── docker-compose.yml        # Definición de servicios Docker
├── Dockerfile                # Imagen personalizada del backend
├── init.ps1                  # Script de inicio rápido (PowerShell)
├── init.sh                   # Script de inicio rápido (bash)
├── LICENSE
└── README.md                 # Documentación del proyecto
```