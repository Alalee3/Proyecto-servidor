# Análisis del Proyecto y Estándares de Diseño (SAUPA)

Este documento define las pautas de arquitectura y diseño que deben seguirse para cualquier nuevo desarrollo en el sistema, tomando el módulo **PNF** como el estándar de referencia ("Gold Standard").

## 1. Arquitectura de Backend (Repositorios)
Para mantener la lógica de base de datos desacoplada de los componentes Livewire, se debe utilizar el patrón de repositorios:
- **Ubicación**: `app/Repositories/[Modulo]/`.
- **Estructura**: Dividir en archivos especializados:
  - `[Modulo]IndexRepo.php`: Métodos para `listar()`, `inhabilitar()` y `restaurar()`.
  - `[Modulo]CreateRepo.php`: Método `crear()`.
  - `[Modulo]EditRepo.php`: Métodos `obtenerPorId()` y `actualizar()`.
  - `[Modulo]ViewRepo.php`: Método `mostrar()`.
- **Implementación**: Usar `DB::table` (Query Builder) directamente para maximizar el rendimiento y control.

## 2. Lógica de Componentes (Livewire)
- **Validación**: Utilizar **Livewire Forms** (`app/Livewire/Forms/[Modulo]/`).
  - Nombres estandarizados: `Create[Modulo]Form`, `Update[Modulo]Form`.
  - Las reglas de validación y mensajes personalizados deben estar dentro del formulario.
- **Métodos del Componente**:
  - Para edición: Los métodos deben llamarse `actualizar()` y `cancelar()`.
  - Para creación: El método debe llamarse `guardar()`.
  - Para visualización: El método de salida debe llamarse `cerrar()`.

## 3. Estándares de Diseño (Blade/UI)
La interfaz debe ser limpia, consistente y utilizar componentes Blade predefinidos.

### 3.1 Listado (List)
- **Buscador**: Componente `<x-table.search-input />` alineado a la izquierda.
- **Navegación**: Si el registro se puede acceder desde la barra lateral, **no debe haber** un botón de "Nuevo" en la vista de lista.
- **Tabla**: 
  - Columnas: Usar nombres cortos y directos (ej: "Nombre" en lugar de "Nombre del PNF").
  - Estilos: Alineación a la derecha para Estatus y Acciones.
  - Estatus: Badges de color (verde para Activo, rojo para Inactivo).

### 3.2 Registro (Create)
- **Contenedor**: Usar un div con padding y sombra: `p-4 sm:p-8 bg-white dark:bg-gray-800 shadow sm:rounded-lg`.
- **Cabecera**: Texto en mayúsculas, centrado y con color `text-xl text-gray-500`.
- **Botones**: Alineados a la derecha, solo el botón de "Guardar [Modulo]".

### 3.3 Edición (Update)
- **Consistencia**: Misma estructura de grid y contenedores que la creación.
- **Botón Volver**: Usar `<x-danger-button>` con `wire:click="cancelar"`. Debe incluir el icono `arrow_back` de Material Symbols.

### 3.4 Visualización (Show)
- **Cabecera Dinámica**: 
  - Título normal: `text-gray-800`.
  - Título inactivo: `text-red-600` (e incluir la palabra "Inactivo/a" en el título).
- **Layout**: Grid de información (`grid-cols-1 sm:grid-cols-2 lg:grid-cols-3`).
- **Valores**: Usar fuentes grandes y negritas (`text-2xl font-semibold`) para los datos mostrados.
- **Botón Volver**: `<x-danger-button>` con icono `arrow_back`.

## 4. Convenciones de Rutas
- Seguir el patrón de nombres de PNF en `routes/web.php`:
  - `[modulo]/listar` -> Componente List
  - `[modulo]/crear` -> Componente Create
  - `[modulo]/update/{id}` -> Componente Update
  - `[modulo]/show/{id}` -> Componente Show
