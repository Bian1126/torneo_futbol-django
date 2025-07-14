# Tutorial: Despliegue de "Torneo Fútbol" en Django con Docker + MongoDB v2

Práctico de Mapeo Objeto-Relacional para la materia **Bases de Datos**, Ingeniería en Sistemas, UTN FRVM.

**Stack:**  
[![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/)
[![Docker Desktop](https://img.shields.io/badge/Docker%20Desktop-2496ED?style=for-the-badge&logo=docker&logoColor=white)](https://www.docker.com/products/docker-desktop)
[![Django 5.1.11](https://img.shields.io/badge/Django%205.1.11-092E20?style=for-the-badge&logo=django&logoColor=white)](https://www.djangoproject.com/)
[![Alpine Linux](https://img.shields.io/badge/Alpine%20Linux-0D597F?style=for-the-badge&logo=alpinelinux&logoColor=white)](https://alpinelinux.org/)
[![Python 3.13](https://img.shields.io/badge/Python%203.13-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://www.python.org/)
[![PostgreSQL 15](https://img.shields.io/badge/PostgreSQL%2015-336791?style=for-the-badge&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
---

## Tecnologías utilizadas

* Docker + Docker Compose  
* Django 5.1.11  
* Python 3.13  
* PostgreSQL 15  
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

Este proyecto tiene como finalidad aplicar los contenidos vistos en la Cátedra de Bases de Datos mediante el desarrollo de un sistema de **gestión de torneos de fútbol**. Integra PostgreSQL y MongoDB para practicar conceptos de modelado y persistencia de datos en modelos relacionales y no relacionales.

---

## Requisitos Previos

* Docker y Docker Compose instalados en tu sistema. Puedes consultar la [documentación oficial de Docker](https://docs.docker.com/get-started/get-docker/) para la instalación.
* Recomendado: Docker Desktop instalado y en ejecución (recomendado para manejar visualmente los contenedores y facilitar la administración). [Descargar Docker Desktop](https://www.docker.com/products/docker-desktop/) 
* Conocimientos básicos de Django y Python (no excluyente, el tutorial es autoexplicativo).

### Recursos Útiles

* [Tutorial oficial de Django](https://docs.djangoproject.com/en/2.0/intro/tutorial01/)
* [Cómo crear un entorno en Python](https://docs.djangoproject.com/en/2.0/intro/contributing/)
* [Documentación oficial de Docker](https://docs.docker.com/get-started/)
* [Guía rápida de Docker Compose](https://docs.docker.com/compose/gettingstarted/)

---

## Instrucciones de cómo levantar el proyecto

### 1. Clonar el repositorio
> Puedes copiar todo este bloque y pegarlo directamente en tu terminal.
```bash
git clone https://github.com/Bian1126/torneo_futbol-django.git
cd torneo_futbol-django
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
[http://localhost:8001/admin](http://localhost:8001/admin)

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
