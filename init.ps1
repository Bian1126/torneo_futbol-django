# init.ps1 - Inicialización del proyecto (PowerShell para Windows)
# -------------------------------------------
# Este script se debe ejecutar la primera vez que se levanta el proyecto.
# Ejecutar desde PowerShell con: .\init.ps1
# -------------------------------------------

# 1. Elimina todos los contenedores, volúmenes y redes creados previamente.
# Útil si querés hacer una limpieza completa antes de comenzar.
docker compose down -v --remove-orphans --rmi all

# 2. Genera archivos de migración de Django según los modelos definidos.
docker compose run --rm manage makemigrations

# 3. Aplica las migraciones a la base de datos PostgreSQL.
docker compose run --rm manage migrate

# 4. Levanta el servicio backend (Django) en segundo plano.
docker compose up -d backend

# 5. Crea un superusuario llamado 'admin' sin pedir datos por consola.
docker compose run --rm manage createsuperuser --noinput --username admin --email admin@example.com

# 6. Establece la contraseña del superusuario a 'admin'.
# Esto se hace manualmente porque --noinput no permite definirla en el paso anterior.
docker compose run --rm manage shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); u=User.objects.get(username='admin'); u.set_password('admin'); u.save()"

# 7. Carga datos iniciales desde el archivo de fixtures ubicado en la app 'torneo'.
docker compose run --rm manage loaddata torneo/fixtures/initial_data.json

# 8. Mensaje final para el usuario
echo ""
echo "Proyecto inicializado correctamente."
echo "Link de acceso: http://localhost:8000/admin"
echo "Usuario: admin"
echo "Contrasenia: admin"
