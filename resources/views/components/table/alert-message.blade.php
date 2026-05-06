@props(['type' => 'success', 'message' => ''])

<div x-data="{
    show: false,
    alertType: 'success',
    alertMessage: '',
    redirectUrl: null,
    isSuccess() { return this.alertType === 'success' },
    showAlert(data) {
        this.alertType = data.type || 'success';
        this.alertMessage = data.message || 'Operación completada';
        this.redirectUrl = data.redirect || null;
        this.show = true;
    },
    handleOk() {
        this.show = false;
        if (this.redirectUrl) {
            setTimeout(() => { window.location.href = this.redirectUrl; }, 100);
        }
    }
}"
x-on:show-alert.window="showAlert($event.detail)"
wire:ignore
class="fixed inset-0 flex items-center justify-center p-4 bg-gray-950/80 backdrop-blur-sm"
style="z-index: 9999999;"
x-cloak
x-show="show"
x-transition:enter="transition ease-out duration-100"
x-transition:enter-start="opacity-0 scale-95"
x-transition:enter-end="opacity-100 scale-100"
x-transition:leave="transition ease-in duration-75"
x-transition:leave-start="opacity-100 scale-100"
x-transition:leave-end="opacity-0 scale-95">
    
    <div class="relative bg-white dark:bg-gray-900 rounded-3xl shadow-2xl max-w-md w-full overflow-hidden border-2"
         :class="isSuccess() ? 'border-green-500' : 'border-red-500'">
        
        <div class="h-24 flex items-center justify-center"
             :class="isSuccess() ? 'bg-gradient-to-br from-green-400 to-emerald-600' : 'bg-gradient-to-br from-red-400 to-rose-600'">
            <div class="bg-white/20 backdrop-blur-md rounded-full p-3">
                <span class="material-icons text-white text-5xl" 
                      x-text="isSuccess() ? 'check_circle' : 'report_problem'"></span>
            </div>
        </div>

        <div class="p-6 text-center">
            <h3 class="text-2xl font-black mb-3 tracking-tight" 
                :class="isSuccess() ? 'text-green-600 dark:text-green-400' : 'text-red-600 dark:text-red-400'"
                x-text="isSuccess() ? '¡GUARDADO EXITOSAMENTE!' : '¡HAY ERRORES!'"></h3>
            
            <div class="mt-3 mb-6 max-h-[40vh] overflow-y-auto px-3 py-3 text-left bg-gray-50 dark:bg-gray-800/50 rounded-xl border border-gray-200 dark:border-gray-700">
                <p class="text-sm font-semibold text-gray-700 dark:text-gray-300 whitespace-pre-line leading-relaxed" 
                   x-text="alertMessage"></p>
            </div>
            
            <button type="button" @click="handleOk()"
                    class="w-full py-4 px-6 text-white rounded-xl font-black uppercase tracking-widest transition-all shadow-lg active:scale-95 text-base"
                    :class="isSuccess() ? 'bg-green-600 hover:bg-green-700' : 'bg-red-600 hover:bg-red-700'">
                OK
            </button>
        </div>
    </div>
    
    <style>[x-cloak] { display: none !important; }</style>
</div>