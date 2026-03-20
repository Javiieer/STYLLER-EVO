# STYLLER-EVO - Instrucciones de Compilación

## Requisitos Previos

### Windows
1. **Visual Studio 2022** o superior (con C++ development tools)
2. **CMake** 3.16 o superior
3. **vcpkg** (gestor de paquetes)
4. **Git**

### Linux
1. **GCC** 7+ o **Clang** 6+
2. **CMake** 3.16 o superior
3. **vcpkg** (gestor de paquetes)
4. **Git**
5. Librerías del sistema:
   ```bash
   sudo apt-get install build-essential cmake git libssl-dev libsqlite3-dev
   ```

## Instalación de vcpkg

### Primera vez (si no tienes vcpkg instalado)

**Windows (PowerShell):**
```powershell
git clone https://github.com/Microsoft/vcpkg.git C:\vcpkg
cd C:\vcpkg
.\bootstrap-vcpkg.bat
# Agregar vcpkg al PATH
$env:VCPKG_ROOT = "C:\vcpkg"
[Environment]::SetEnvironmentVariable("VCPKG_ROOT", "C:\vcpkg", "User")
```

**Linux:**
```bash
git clone https://github.com/Microsoft/vcpkg.git ~/vcpkg
cd ~/vcpkg
./bootstrap-vcpkg.sh
# Agregar al .bashrc o .zshrc
echo 'export VCPKG_ROOT="$HOME/vcpkg"' >> ~/.bashrc
source ~/.bashrc
```

## Compilación

### Método 1: Usando CMake Presets (Recomendado)

**Windows:**
```powershell
# Instalar dependencias
vcpkg install

# Configurar el proyecto
cmake --preset windows-release

# Compilar
cmake --build build --config Release
```

**Linux:**
```bash
# Instalar dependencias
vcpkg install

# Configurar el proyecto
cmake --preset linux-release

# Compilar
cmake --build build
```

### Método 2: Manual

**Windows:**
```powershell
# Crear directorio de build
mkdir build
cd build

# Configurar con vcpkg
cmake .. -DCMAKE_TOOLCHAIN_FILE=$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release

# Compilar
cmake --build . --config Release
```

**Linux:**
```bash
# Crear directorio de build
mkdir build
cd build

# Configurar con vcpkg
cmake .. -DCMAKE_TOOLCHAIN_FILE=$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake -DCMAKE_BUILD_TYPE=Release

# Compilar
cmake --build .
```

## Ubicación del Ejecutable

Después de compilar, el ejecutable `theotxserver` estará en:
- **Windows:** `build\bin\Release\theotxserver.exe`
- **Linux:** `build/bin/theotxserver`

## Compilación en Modo Debug

Para compilar en modo debug (útil para desarrollo):

**Windows:**
```powershell
cmake --preset windows-debug
cmake --build build --config Debug
```

**Linux:**
```bash
cmake --preset linux-debug
cmake --build build
```

## Problemas Comunes

### Error: "VCPKG_ROOT not found"
Asegúrate de que la variable de entorno `VCPKG_ROOT` esté configurada correctamente y apunte a tu instalación de vcpkg.

### Error con tcmalloc en Linux
Si no tienes tcmalloc instalado:
```bash
sudo apt-get install libtcmalloc-minimal4
```

### Error con MySQL/MariaDB
Vcpkg instalará automáticamente libmariadb. Si tienes problemas, asegúrate de que vcpkg esté actualizado:
```bash
cd $VCPKG_ROOT
git pull
./bootstrap-vcpkg.sh  # Linux
# o
.\bootstrap-vcpkg.bat  # Windows
```

## Limpiar Build

Para limpiar y recompilar desde cero:
```bash
rm -rf build  # Linux
# o
Remove-Item -Recurse -Force build  # Windows PowerShell
```

## Notas Adicionales

- El proyecto usa **MySQL** como base de datos por defecto
- Las optimizaciones están habilitadas en modo Release (`-Ofast` en Linux)
- En Linux se usa `tcmalloc` para mejor rendimiento de memoria si está disponible
- Los presets de CMake facilitan la compilación y son compatibles con Visual Studio Code

## Soporte

Para más información sobre el proyecto OTX Server:
- [The Forgotten Server](https://github.com/otland/forgottenserver)
- [OTX Server](https://github.com/mattyx14/otxserver)
