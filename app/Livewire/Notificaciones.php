<?php

namespace App\Livewire;

use Livewire\Component;
use Illuminate\Support\Str;

class Notificaciones extends Component
{
    public $mostrar = false;
    public $mensaje;
    public $tipo;
    public $color;
    public $notificationId; // Nueva propiedad para el wire:key

    protected $listeners = ['mostrar-mensaje' => 'mostrar'];

    public function mostrar($data)
    {
        $this->mensaje = $data['mensaje'] ?? 'Mensaje por defecto';
        $this->tipo = $data['tipo'] ?? 'info';
        
        // Determina el color basado en el tipo si no se proporciona explícitamente
        // o si tu lógica para $color ya está en $data, ajústala según sea necesario.
        $this->color = $data['color'] ?? $this->getColorForType($this->tipo);
        
        $this->notificationId = Str::random(8); // Genera un nuevo ID único para la notificación
        $this->mostrar = true;
        
    }

    private function getColorForType($tipo)
    {
        switch (strtolower($tipo)) {
            case 'exitoso':
                return 'green';
            case 'error':
                return 'red';
            case 'warning':
                return 'yellow';
            case 'info':
            default:
                return 'blue'; // Asegúrate de que estos colores (green, red, yellow, blue)
                               // estén cubiertos por tus clases de Tailwind (e.g., bg-green-200, text-red-700)
        }
    }

    public function render()
    {
        return view('livewire.notificaciones');
    }
}
