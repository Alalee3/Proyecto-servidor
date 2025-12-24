<?php

namespace App\Livewire;

use Livewire\Component;

class DarkModeToggle extends Component
{
    public $darkMode; // Propiedad para guardar el estado del modo oscuro

    public function mount()
    {
        // Intentar obtener la preferencia del usuario desde localStorage o base de datos si la tuvieras
        // Por ahora, asumimos que se carga desde el estado inicial del cliente o por defecto a falso (claro)
        $this->darkMode = false; // Por defecto iniciamos en modo claro
    }

    public function toggleDarkMode()
    {
        $this->darkMode = !$this->darkMode; // Cambia el estado
        // Emitir un evento de Alpine.js para que el frontend actualice la clase 'dark'
        $this->dispatch('toggle-dark-mode', $this->darkMode);

        // Aquí podrías guardar la preferencia en la base de datos si el usuario está logueado
        // Por ejemplo: auth()->user()->update(['dark_mode' => $this->darkMode]);
    }

    public function render()
    {
        return view('livewire.dark-mode-toggle');
    }
}
