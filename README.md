# STYLLER-EVO Server

<div align="center">

**Servidor OTX optimizado y personalizado**

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen)]()
[![C++11](https://img.shields.io/badge/C++-11-blue.svg)]()
[![CMake](https://img.shields.io/badge/CMake-3.16+-blue.svg)]()
[![License](https://img.shields.io/badge/license-GPL-blue.svg)]()

</div>

## 📋 Descripción

STYLLER-EVO es un servidor de Tibia basado en OTX Server (The OTX Server), optimizado y personalizado con características únicas y mejoras de rendimiento.

## ✨ Características

- 🎮 Sistema completo de juego compatible con cliente Tibia
- 💾 Base de datos MySQL/MariaDB
- 🔧 Sistema de configuración modular
- 📊 Scripts Lua para extensibilidad
- 🚀 Optimizado para alto rendimiento
- 🛡️ Sistema anti-rollback
- 🏰 Sistemas de raids, spawns y quests
- 👥 Sistema de guild y party

## 🔧 Requisitos

### Windows
- Visual Studio 2022 o superior
- CMake 3.16+
- vcpkg
- Git

### Linux
- GCC 7+ o Clang 6+
- CMake 3.16+
- vcpkg
- Bibliotecas: libssl-dev, libsqlite3-dev

## 🚀 Compilación

Para instrucciones detalladas de compilación, consulta [docs/BUILD.md](docs/BUILD.md).

### Inicio Rápido

**Windows:**
```powershell
vcpkg install
cmake --preset windows-release
cmake --build build --config Release
```

**Linux:**
```bash
vcpkg install
cmake --preset linux-release
cmake --build build
```

## 📁 Estructura del Proyecto

```
STYLLER-EVO/
├── cmake/              # Módulos de CMake
├── data/               # Datos del servidor (spawns, monsters, etc.)
├── docs/               # Documentación
├── mods/               # Modificaciones y extensiones
├── src/                # Código fuente C++
├── vc17/               # Archivos de Visual Studio
├── CMakeLists.txt      # Configuración de CMake
├── CMakePresets.json   # Presets de compilación
├── config.lua          # Configuración principal
├── vcpkg.json          # Dependencias
└── styller.sql         # Base de datos SQL
```

## 🎮 Uso

1. Importa la base de datos: `styller.sql`
2. Configura `config.lua` con tus parámetros
3. Ejecuta el servidor:
   ```bash
   ./theotxserver  # Linux
   # o
   theotxserver.exe  # Windows
   ```

## 📦 Dependencias

El proyecto utiliza las siguientes bibliotecas (gestionadas automáticamente por vcpkg):

- **Boost** (asio, filesystem, thread, regex, iostreams)
- **LuaJIT** - Motor de scripting
- **LibXML2** - Parsing XML
- **PugiXML** - Parsing XML adicional
- **fmt** - Formateo de strings
- **MariaDB** - Cliente de base de datos
- **GMP/MPIR** - Aritmética de precisión múltiple

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu característica (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia GPL. Ver el archivo LICENSE para más detalles.

## 👏 Créditos

Basado en:
- [The OTX Server](https://github.com/mattyx14/otxserver)
- [The Forgotten Server](https://github.com/otland/forgottenserver)

## 📞 Soporte

Para reportar bugs o solicitar características, por favor abre un issue en el repositorio.

---

<div align="center">
Hecho con ❤️ por la comunidad OTX
</div>
