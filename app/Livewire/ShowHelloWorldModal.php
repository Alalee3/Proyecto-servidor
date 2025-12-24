<?php

namespace App\Livewire;

use Livewire\Component;
use WireElements\Modal\BaseModal; // ¡Importante!
use LivewireUI\Modal\ModalComponent;

class ShowHelloWorldModal extends ModalComponent // ¡Importante!
{
    public function render()
    {
        return view('livewire.show-hello-world-modal');
    }
}
