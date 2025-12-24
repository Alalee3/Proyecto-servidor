<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planificacion</title>

    {{-- Favicon: Usa asset() para la ruta correcta desde la carpeta 'public' --}}
    <link rel="icon" href="{{ asset('assets/Logotipo UPTP.ico') }}">

    {{--
    **********************************************************************************
    * ADVERTENCIA IMPORTANTE:
    * Tu proyecto Laravel ya está cargando Tailwind CSS a través de @vite(['resources/css/app.css', ...]).
    * Cargar 'style.css' adicionalmente PUEDE CAUSAR CONFLICTOS DE ESTILOS.
    * style.css intentará anular o se verá anulado por Tailwind.
    **********************************************************************************
    --}}

    {{-- 1. Carga los estilos y scripts principales de Laravel/Vite (incluye Tailwind CSS por defecto) --}}
    @vite(['resources/css/app.css', 'resources/js/app.js'])

    {{-- 2. Carga tu CSS personalizado *DESPUÉS* de Tailwind para darle más prioridad --}}
    {{-- Asegúrate de que style.css esté en public/css/style.css --}}
    <link rel="stylesheet" href="{{ asset('css/style.css') }}">

    {{-- Kit para Font Awesome - Es una URL externa, así que no necesita asset() --}}
    <script src="https://kit.fontawesome.com/3d06fc60b2.js" crossorigin="anonymous"></script>

</head>

{{-- El cuerpo del documento empieza aquí, sin los divs de fondo de Laravel --}}

<body>

    {{-- ************************************************************************ --}}
    {{-- A PARTIR DE AQUÍ COMIENZA EL HTML DE TU HOMEPAGE ORIGINAL --}}
    {{-- ************************************************************************ --}}

    <nav>
        <div class="logo">
            {{-- Imagen del Ministerio: Usa asset() --}}
            <img src="{{ asset('assets/img/Ministerio.png') }}" alt="logotipoMinisterioEducacion">
        </div>
        <ul id="menuList">
            <li><a href="#Inicio">Inicio</a></li>
            <li><a href="#Servicios">Servicios</a></li>
            <li><a href="#Acerca">Acerca de</a></li>
            <li><a href="#Sobre">Sobre Nosotros</a></li>
            {{-- Enlace a Login: Usa route() --}}
            <li><a href="{{ route('login') }}">Ingresar</a></li>
        </ul>
        <div class="menu-icon">
            <i class="fa-solid fa-bars" onclick="toggleMenu()"></i>
        </div>
    </nav>
    <section class="seccionpagina1" id="Inicio">
        <div class="contenido-centro-a">
            <h2>Planificación Académica Eficiente</h2>
            <hr>
            <p>Optimiza la planificación y gestión de las actividades académicas, contribuyendo a una organización
                eficiente y a un mejor desempeño institucional.</p>
            <a class="botonprimario" href="#Servicios">Más Información</a>
        </div>
    </section>
    <section class="seccionpagina2" id="Servicios">
        <div class="contenido-centro-b">
            <h2>Servicios</h2>
            <hr>
            {{-- Imagen de Servicios: Usa asset() --}}
            <img src="{{ asset('assets/img/Servicios.png') }}" alt="serviciosimg">
            <hr>
            <div class="servicios-lista">
                <ul class="lista-en-grid">
                    <li>Registro y seguimiento de actividades docentes y estudiantes.</li>
                    <li>Programación y control de fechas para entregas y evaluaciones.</li>
                    <li>Control de asignación de materias y profesores.</li>
                    <li>Archivo digital centralizado de documentos y planes académicos.</li>
                </ul>
            </div>
        </div>
    </section>
    <section class="seccionpagina3" id="Acerca">
        <div class="contenido-centro-c">
            <h2 class="h2-centrado">Nuestro Propósito</h2>
            <hr>
            <div class="fila-contenido-c">
                <div class="columna-clase-c">
                    {{-- Imagen de Mision: Usa asset() --}}
                    <img src="{{ asset('assets/img/Mision.png') }}">
                    <h3>Misión</h3>
                    <ul>
                        <li>Optimizar la organización y programación de actividades para maximizar el uso eficiente del
                            tiempo y recursos.</li>
                        <li>Facilitar el seguimiento y coordinación de tareas para mejorar la productividad y
                            comunicación entre usuarios.</li>
                    </ul>
                </div>
                <div class="columna-clase-c">
                    {{-- Imagen de Vision: Usa asset() --}}
                    <img src="{{ asset('assets/img/Vision.png') }}">
                    <h3>Visión</h3>
                    <ul>
                        <li>Liderar la gestión y planificación de actividades, destacando por su facilidad de uso y
                            adaptabilidad.</li>
                        <li>Impulsar la transformación digital en la organización del trabajo, promoviendo la
                            colaboración eficiente y el logro de objetivos en tiempo récord.</li>
                    </ul>
                </div>
                <div class="columna-clase-c">
                    {{-- Imagen de Valores: Usa asset() --}}
                    <img src="{{ asset('assets/img/Valores.png') }}">
                    <h3>Valores</h3>
                    <ul>
                        <li>Compromiso con optimizar procesos para ahorrar tiempo y recursos, promoviendo la eficiencia.
                        </li>
                        <li>Garantizar una experiencia intuitiva y accesible para todos los usuarios.</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <section class="seccionpagina4" id="Sobre">
        <div class="contenido-centro-d">
            <h2>¿Quienes somos?</h2>
            <p>La Universidad Politécnica Territorial del Estado Portuguesa Juan de Jesús Montilla, es una universidad
                venezolana, con su sede ubicada en la ciudad de Acarigua, siendo la principal casa de estudios
                superiores de dicha ciudad y considerada una de las entre más importantes del estado.</p>
            <div class="ofertas">
                <h2>Ofertas de Programas Nacionales de Formación (PNF) :</h2>
                <ul class="lista-ofertas">
                    <li>Informática</li>
                    <li>Agroalimentación</li>
                    <li>Electricidad</li>
                    <li>Mecánica</li>
                    <li>Mantenimiento</li>
                    <li>Procesamiento y Distribución de alimentos</li>
                    <li>Administración</li>
                    <li>Distribución y Loguística</li>
                    <li>Seguridad Alimentaria</li>
                    <li>Medicina Veterinaria</li>
                </ul>
            </div>
        </div>
    </section>
    <footer class="footer">
        <a href="https://www.instagram.com/prensauptpjjmontilla" target="_blank">
            {{-- Imagen de Instagram: Usa asset() --}}
            <img src="{{ asset('assets/img/instagram-icon.png') }}">
        </a>
        <div class="contenedor">
            <p>Av. Circunvalación Sur, Sector Bellas Artes, Diagonal Cruz Roja, Acarigua Estado Portuguesa - Todos los
                Derechos Reservados</p>
        </div>
    </footer>

    {{-- ************************************************************************ --}}
    {{-- FIN DEL HTML DE TU HOMEPAGE ORIGINAL --}}
    {{-- ************************************************************************ --}}

    {{-- Carga tu JavaScript personalizado *DESPUÉS* del JavaScript de Laravel (app.js) --}}
    {{-- Asegúrate de que script.js esté en public/js/script.js --}}
    <script src="{{ asset('js/script.js') }}"></script>

</body>

</html>
