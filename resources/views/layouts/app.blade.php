<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

    <script>
        // Check localStorage first for user preference
        const storedTheme = localStorage.getItem('theme');

        if (storedTheme === 'dark' || (storedTheme === null && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
            // If theme is explicitly dark or no preference is stored and system prefers dark
            document.documentElement.classList.add('dark');
        } else {
            // Otherwise, ensure dark class is removed (for light mode)
            document.documentElement.classList.remove('dark');
        }
    </script>

    <!-- Scripts -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])

    @livewireStyles
</head>

<body class="font-sans antialiased">
    <div class="min-h-screen bg-gray-100 dark:bg-gray-900">
        <livewire:layout.navigation />

        {{-- Alpine.js wrapper para el estado de la sidebar --}}
        <div x-data="{ alpineSidebarOpen: false }"
            @sidebar-state-changed.window="alpineSidebarOpen = $event.detail.isOpen; console.log('Alpine: sidebar state changed to', $event.detail.isOpen)">

            <div class="flex"> {{-- Contenedor Flex principal para la sidebar y el área de contenido --}}
                <livewire:side-bar />

                {{-- Área de contenido principal que será empujada por la sidebar --}}
                <div id="main-content-wrapper" class="flex-1 transition-all duration-300 ease-in-out"
                    :class="{ 'lg:ml-64': alpineSidebarOpen, 'ml-0': !alpineSidebarOpen }">


                    <livewire:notificaciones /> {{-- Componente de notificaciones, movido aquí --}}

                    <!-- Page Heading -->
                    @if (isset($header))
                        <header class="bg-white dark:bg-gray-800 shadow">
                            <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                                {{ $header }}
                            </div>
                        </header>
                    @endif

                    <!-- Page Content -->
                    <main>
                        {{-- Este div provee el padding consistente para el contenido de la página ($slot) --}}
                        {{-- Similar a la estructura en dashboard.blade.php --}}
                        <div class="py-12">
                            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-6">
                                {{ $slot }}
                            </div>
                        </div>
                    </main>
                </div>
            </div>
        </div>

    </div>
    @livewireScripts
    @livewire('livewire-ui-modal')
</body>

</html>