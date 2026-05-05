@props(['type' => 'success', 'message' => ''])

<div x-data="{ 
    show: false,
    alertType: '{{ $type }}',
    alertMessage: {!! json_encode((string)$message) !!},
    isSuccess() { return ['success', 'exitoso', 'exito'].includes(this.alertType) }
}"
x-init="
    if (alertMessage && alertMessage.length > 0) {
        show = true;
    }
"
x-on:show-alert.window="
    let detail = $event.detail;
    if (Array.isArray(detail) && detail.length > 0) detail = detail[0];
    
    show = true; 
    alertType = detail.type || 'success'; 
    alertMessage = detail.message || 'Operación completada';
"
wire:ignore
class="fixed inset-0 flex items-center justify-center p-4 bg-gray-900/90 backdrop-blur-md"
style="z-index: 9999999;"
x-cloak
x-show="show">
    
    <div class="bg-white dark:bg-gray-800 rounded-3xl shadow-2xl max-w-md w-full border-4"
         :class="isSuccess() ? 'border-green-500' : 'border-red-500'"
         @click.away="show = false">
        <div class="p-8 text-center">
            <div class="mb-4">
                <span class="material-icons text-6xl" 
                      :class="isSuccess() ? 'text-green-500' : 'text-red-500'"
                      x-text="isSuccess() ? 'check_circle' : 'error'"></span>
            </div>
            
            <h3 class="text-2xl font-black mb-2 dark:text-white" 
                x-text="isSuccess() ? '¡GUARDADO!' : '¡HAY ERRORES!'"></h3>
            
            <div class="mt-4 mb-6 max-h-[60vh] overflow-y-auto px-2 text-left">
                <p class="text-sm font-bold text-gray-700 dark:text-gray-300 whitespace-pre-line" 
                   x-text="alertMessage"></p>
            </div>
            
            <button type="button" @click="show = false"
                    class="w-full py-4 px-6 text-white rounded-2xl font-black uppercase tracking-widest transition-all shadow-lg active:scale-95"
                    :class="isSuccess() ? 'bg-green-600 hover:bg-green-700' : 'bg-red-600 hover:bg-red-700'">
                ENTENDIDO (OK)
            </button>
        </div>
    </div>
    
    <style>
        [x-cloak] { display: none !important; }
    </style>
</div>