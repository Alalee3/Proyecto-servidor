<div x-data="{
    isDarkMode: false,
    init() {
        // Al inicializar el componente, primero intentamos leer de localStorage
        const savedMode = localStorage.getItem('theme');

        if (savedMode === 'dark') {
            this.isDarkMode = true; // Si hay preferencia 'dark', activamos el modo oscuro
        } else if (savedMode === 'light') {
            this.isDarkMode = false; // Si hay preferencia 'light', desactivamos el modo oscuro
        } else {
            // Si no hay preferencia guardada, usamos la preferencia del sistema operativo
            this.isDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
            // Opcional: Guarda esta preferencia del sistema como la inicial
            localStorage.setItem('theme', this.isDarkMode ? 'dark' : 'light');
        }

        // Aplicar el tema inmediatamente al elemento <html>
        this.applyTheme();
    },
    toggleLocalMode() {
        this.isDarkMode = !this.isDarkMode; // Invertimos el estado
        this.applyTheme(); // Aplicamos el nuevo estado y lo guardamos
    },
    applyTheme() {
        if (this.isDarkMode) {
            document.documentElement.classList.add('dark'); // Añade la clase 'dark'
            localStorage.setItem('theme', 'dark'); // Guarda la preferencia en localStorage
        } else {
            document.documentElement.classList.remove('dark'); // Remueve la clase 'dark'
            localStorage.setItem('theme', 'light'); // Guarda la preferencia en localStorage
        }
    }
}">
    <style>
        /*
        * Importante: Este estilo oculta los elementos con x-cloak hasta que Alpine.js los inicialice.
        * Esto previene el "flash" de contenido antes de que Alpine.js oculte/muestre los elementos
        * según la lógica de x-show.
        */
        [x-cloak] {
            display: none !important;
        }
    </style>

    <button @click="toggleLocalMode()"
        class="p-2 rounded-full text-gray-700 bg-gray-200 hover:bg-gray-300
               dark:text-gray-300 dark:bg-gray-700 dark:hover:bg-gray-600 focus:outline-none focus:ring-2 focus:ring-indigo-500">
        {{-- Icono para Modo Claro (sol) - oculto inicialmente por x-cloak --}}
        <span x-show="!isDarkMode" x-cloak>
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M12 3v1m0 16v1m9-9h1M3 12h1m15.325-4.243l.707-.707M3.929 19.071l.707-.707m0-11.314l-.707-.707m11.314 0l.707-.707M12 18a6 6 0 100-12 6 6 0 000 12z">
                </path>
            </svg>
        </span>
        {{-- Icono para Modo Oscuro (luna) - oculto inicialmente por x-cloak --}}
        <span x-show="isDarkMode" x-cloak>
            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                xmlns="http://www.w3.org/2000/svg">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                    d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"></path>
            </svg>
        </span>
    </button>
</div>
