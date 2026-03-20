# Guía de Configuración - STYLLER-EVO

## Configuración de la Base de Datos

### 1. Crear la Base de Datos MySQL/MariaDB

```sql
CREATE DATABASE styller CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'styller'@'localhost' IDENTIFIED BY 'tu_contraseña_segura';
GRANT ALL PRIVILEGES ON styller.* TO 'styller'@'localhost';
FLUSH PRIVILEGES;
```

### 2. Importar el Schema

```bash
# Linux/Mac
mysql -u styller -p styller < styller.sql

# Windows
mysql.exe -u styller -p styller < styller.sql
```

## Configuración del config.lua

El archivo `config.lua` es el archivo principal de configuración del servidor. A continuación se detallan las opciones más importantes:

### Configuración de Base de Datos

```lua
-- Database
sqlType = "mysql"
sqlHost = "localhost"
sqlPort = 3306
sqlUser = "styller"
sqlPass = "tu_contraseña_segura"
sqlDatabase = "styller"
sqlFile = "styller.sql"
sqlKeepAlive = 0
mysqlReadTimeout = 10
mysqlWriteTimeout = 10
encryptionType = "sha1"  -- plain, md5, sha1, sha256, sha512
```

### Configuración del Servidor

```lua
-- Server
worldType = "pvp"  -- pvp, no-pvp, pvp-enforced
serverName = "STYLLER-EVO"
ownerName = "Admin"
ownerEmail = "admin@styller.com"
url = "http://www.styller.com"
location = "America"

-- Server IP/Puerto
ip = "127.0.0.1"
loginPort = 7171
gamePort = 7172
statusPort = 7171
```

### Configuración de Rates

```lua
-- Rates
rateExperience = 5.0
rateSkill = 3.0
rateMagic = 3.0
rateLoot = 2.0
rateSpawn = 1.0

-- Monster rates
rateMonsterHealth = 1.0
rateMonsterAttack = 1.0
rateMonsterDefense = 1.0
```

### Configuración de Cuenta y Personajes

```lua
-- Accounts
loginTries = 5
retryTimeout = 5 * 1000
loginTimeout = 60 * 1000
maxPlayers = 1000
motd = "Bienvenido a STYLLER-EVO!"
onePlayerOnlinePerAccount = true
allowClones = false

-- Characters
maxMessageBuffer = 4
deathLosePercent = -1
```

### Configuración de Spawns

```lua
-- Spawns
deSpawnRange = 2
deSpawnRadius = 50
```

### Configuración de Map

```lua
-- Map
mapName = "styller"
mapAuthor = "Styller Team"
```

## Estructura de Directorios de Data

```
data/
├── actions/          # Scripts de acciones (items usables)
├── creaturescripts/  # Scripts de eventos de criaturas
├── globalevents/     # Eventos globales del servidor
├── items/            # Definiciones de items
├── lib/              # Bibliotecas Lua compartidas
├── monster/          # Definiciones de monstruos
├── movements/        # Scripts de movimiento (tiles)
├── npc/              # NPCs y sus scripts
├── raids/            # Configuración de raids
├── spells/           # Definición de hechizos
├── talkactions/      # Comandos de chat
├── weapons/          # Scripts de armas
└── world/            # Archivos del mundo/mapa
```

## Configuración de Mods

Los mods se ubican en la carpeta `mods/` y permiten extender funcionalidades sin modificar archivos core.

### Estructura de un Mod

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mod name="Mi Mod" version="1.0" author="Tu Nombre" enabled="yes">
    <config name="miModConfig"><![CDATA[
        -- Configuración del mod
        config = {
            enabled = true
        }
    ]]></config>
    
    <event type="login" name="miModLogin" event="script"><![CDATA[
        function onLogin(player)
            -- Script de login
            return true
        end
    ]]></event>
</mod>
```

## Permisos y Grupos

Los grupos se configuran en la base de datos, tabla `groups`. Los permisos incluyen:

- **Player (1)**: Jugador normal
- **Tutor (2)**: Ayudante
- **Senior Tutor (3)**: Tutor senior
- **Gamemaster (4)**: GM
- **Community Manager (5)**: CM
- **God (6)**: Administrador completo

## Comandos Útiles de Administración

### En-game (requiere permisos)

```
/i item_name, cantidad         - Crear item
/s nombre_del_monstruo         - Summon monstruo
/m mensaje                      - Broadcast
/t jugador, ciudad              - Teleportar jugador
/kick jugador                   - Expulsar jugador
/B jugador                      - Ban jugador
```

### Comandos de Base de Datos

```sql
-- Cambiar contraseña de cuenta
UPDATE accounts SET password = SHA1('nueva_contraseña') WHERE name = 'nombre_cuenta';

-- Hacer cuenta God
UPDATE accounts SET type = 5 WHERE name = 'nombre_cuenta';

-- Ver players online
SELECT name FROM players WHERE online = 1;
```

## Troubleshooting

### El servidor no inicia

1. Verifica la conexión a la base de datos en `config.lua`
2. Revisa los logs en `data/logs/`
3. Asegúrate de que los puertos no estén en uso

### No puedo conectarme

1. Verifica el IP en `config.lua`
2. Si juegas local, usa `127.0.0.1`
3. Verifica que tu firewall permita las conexiones
4. Asegúrate de usar el cliente compatible

### Performance bajo

1. Activa tcmalloc en Linux
2. Ajusta `sqlKeepAlive` y timeouts de MySQL
3. Reduce `rateSpawn` si hay muchos monstruos
4. Optimiza las queries de la base de datos

## Optimizaciones Recomendadas

### MySQL

```ini
# my.cnf / my.ini
[mysqld]
max_connections = 200
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
query_cache_size = 64M
thread_cache_size = 8
```

### Sistema (Linux)

```bash
# Aumentar límite de archivos abiertos
ulimit -n 65535

# Optimizar red
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse
```

## Recursos Adicionales

- [OTLand Forums](https://otland.net/)
- [OTServBR](https://forums.otserv.com.br/)
- [TFS Documentation](https://github.com/otland/forgottenserver/wiki)

---

Para más información sobre compilación, consulta [BUILD.md](BUILD.md).
