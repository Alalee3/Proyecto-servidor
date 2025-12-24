<?php
// Archivo: app/Livewire/SideBar.php

namespace App\Livewire;

use Livewire\Component;
use Livewire\Attributes\On; // Importante para Livewire 3

class SideBar extends Component
{
    public bool $isOpen = false; // Inicialmente cerrado para probar el botón de abrir

    /**
     * Escucha el evento 'open-sidebar' para abrir el sidebar desde el exterior.
     * Este evento puede ser disparado por Alpine.js u otro componente Livewire.
     */
    #[On('open-sidebar')]
    public function open()
    {
        $this->isOpen = true;
        // Despacha un evento para que Alpine.js (u otros) puedan reaccionar al cambio de estado.
        $this->dispatch('sidebar-state-changed', isOpen: $this->isOpen);
    }

    /**
     * Alterna el estado del sidebar (abierto/cerrado).
     * Usado por el botón de cierre DENTRO del sidebar.
     */
    public function toggle() // Renombrado de toggleSidebar para evitar confusión con el evento
    {
        $this->isOpen = !$this->isOpen;
        // Despacha un evento para que Alpine.js (u otros) puedan reaccionar al cambio de estado.
        $this->dispatch('sidebar-state-changed', isOpen: $this->isOpen);
    }

    public function render()
    {
        // Asegúrate de que la ruta de la vista sea correcta.
        // Si tu vista está en resources/views/livewire/layout/side-bar.blade.php
        return view('livewire.layout.side-bar', [
            'isOpen' => $this->isOpen, // Pasar explícitamente está bien, aunque las propiedades públicas son accesibles.
        ]);
    }
}
