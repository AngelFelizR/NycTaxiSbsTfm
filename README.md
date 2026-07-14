# Optimización de ingresos para taxistas mediante el análisis de datos de vehículos de alquiler de alta demanda

- **Trabajo de Fin de Máster (TFM)**
- **Programa:** Maestría en Ciencia de Datos
- **Sustentante:** Ángel Esteban Féliz Ferreras
- **Asesor:** Jaime Muñoz Sarciada

Este repositorio contiene todo el entorno de desarrollo y los archivos fuente necesarios para la generación reproducible de la **memoria técnica** y la **presentación de diapositivas** del Trabajo de Fin de Máster (TFM).

El proyecto analiza los datos de vehículos de alquiler de alta demanda (Uber, Lyft, Juno, Via) en los condados de Manhattan, Brooklyn y Queens para proponer estrategias de optimización de ingresos.

---

## 🚀 Entregables Principales

Los productos finales generados por este repositorio se compilan a partir de archivos dinámicos de Quarto (`.qmd`) que integran prosa, código en R y exportaciones a formato PDF:

* **Memoria Técnica:** *Angel-Feliz-DS-TFM.pdf* (Compilado desde `Angel-Feliz-DS-TFM.qmd`)
* **Presentación de Defensa:** *Angel-Feliz-DS-TFM-Presentation.pdf* (Compilado desde `Angel-Feliz-DS-TFM-Presentation.qmd`)

---

## 🛠️ Entorno de Desarrollo y Reproducibilidad

Este proyecto está diseñado bajo el principio de **reproducibilidad absoluta**. Para garantizar que las dependencias de R, LaTeX, Quarto y las librerías del sistema no cambien con el tiempo, el entorno está virtualizado de dos formas complementarias:

### Opción A: Nix (Recomendado para desarrollo local)

El proyecto utiliza el gestor de paquetes **Nix** para declarar con precisión de hash cada paquete de R, fuentes del sistema y la distribución de LaTeX.

Las declaraciones se dividen de forma modular en la carpeta `nix/`:

* `system.nix`: Quarto, Pandoc, R y fuentes de sistema (DejaVu, FreeFont).
* `latex.nix`: Esquema de LaTeX y paquetes específicos de TeX Live (`tcolorbox`, `fancyhdr`, etc.).
* `r-core.nix` & `r-data.nix`: Paquetes base y de análisis (`tidyverse`, `xgboost`, `duckdb`, `data.table`).
* `r-geo.nix`: Herramientas de análisis espacial (`sf`, `osmdata`, `tidycensus`).
* `r-custom.nix`: Paquetes personalizados o específicos compilados desde commits específicos de GitHub (como `corrcat` y `pins`).

**Cómo usarlo:**
Si tienes Nix instalado, simplemente ejecuta en la raíz del proyecto para entrar al entorno con todo configurado:

```bash
nix-shell
# O bien usa el script de inicialización
./setup.sh

```

### Opción B: Docker & Docker Compose

Si prefieres no instalar Nix localmente, se incluye un entorno contenedorizado basado en Docker.

El archivo `docker-compose.yml` monta los directorios locales y expone el contenedor a través de SSH (puerto `2223`) para facilitar el desarrollo remoto o la ejecución de pipelines de compilación.

**Cómo levantar el entorno:**

```bash
docker-compose up -d --build

```

> **Nota sobre volúmenes:** El contenedor espera que existan los directorios hermanos `../NycTaxiPins` y `../NycTaxiBigFiles` para la persistencia de los datasets pesados y pines de datos.

---

## 📂 Estructura del Repositorio

```text
.
├── Angel-Feliz-DS-TFM.qmd              # Código fuente de la memoria técnica (Quarto)
├── Angel-Feliz-DS-TFM.pdf              # Memoria técnica compilada (PDF)
├── Angel-Feliz-DS-TFM-Presentation.qmd # Código fuente de la presentación (Quarto)
├── Angel-Feliz-DS-TFM-Presentation.pdf # Presentación compilada (PDF)
├── portada.tex                         # Plantilla LaTeX para la portada formal
├── references.bib                      # Archivo de referencias bibliográficas (BibTeX)
├── apa.csl                             # Estilo de citas APA para el documento de texto
├── params.yml                          # Variables de diseño y paleta de colores del TFM
├── figures/                            # Gráficos, diagramas de flujo y recursos visuales
├── nix/                                # Declaración modular de dependencias con Nix
├── docker-compose.yml & Dockerfile     # Configuración del entorno de contenedores
├── document-creation-instructions.md   # Guía detallada interna para la compilación
└── setup.sh                            # Script automatizado de configuración inicial

```

---

## ✍️ Instrucciones de Compilación

Una vez dentro de tu entorno (ya sea mediante `nix-shell` o dentro del contenedor Docker), puedes compilar los documentos usando **Quarto CLI**:

### 1. Compilar la Memoria Técnica (PDF)

```bash
quarto render Angel-Feliz-DS-TFM.qmd --to pdf

```

### 2. Compilar la Presentación de Diapositivas (PDF)

```bash
quarto render Angel-Feliz-DS-TFM-Presentation.qmd --to pdf

```

---

## 📊 Tecnologías y Frameworks Clave

* **Motor de Reportes:** [Quarto](https://quarto.org/)
* **Lenguaje de Programación:** R 4.5+ (gestionado vía Nix)
* **Procesamiento de Datos:** `data.table`, `duckdb` y `pins` para manejo eficiente de millones de viajes de taxis/HVFHS de NYC.
* **Modelado Predictivo:** `tidymodels` y `xgboost` para el modelado de la probabilidad de alta demanda.
* **Soporte de Estilos:** LaTeX (con la tipografía parametrizada en `params.yml`).
