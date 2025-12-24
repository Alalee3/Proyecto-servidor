@props(['type' => 'success', 'message' => ''])

@if($message)
    <div 
        class="p-4 mb-4 text-sm rounded-lg relative
            @if($type === 'success')
                text-green-800 bg-green-50 dark:bg-gray-800 dark:text-green-400
            @else
                text-red-800 bg-red-50 dark:bg-gray-800 dark:text-red-400
            @endif"
        role="alert"
        x-data
        x-init="setTimeout(() => { 
            let btn = $el.querySelector('.auto-close-btn'); 
            if(btn) btn.click(); 
        }, 2000)"
    >
        
        <strong class="block font-bold">
            @if($type === 'success') ¡ÉXITO! @else ¡ERROR! @endif
        </strong>
        
        <span class="block mt-1">{{ $message }}</span>
        
        <!-- Botón de cierre -->
        <button
            class="auto-close-btn inline-flex items-center px-2 py-2 absolute top-2 right-2 text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white rounded-lg focus:outline-none transition ease-in-out duration-150"
            onclick="this.parentElement.style.display='none'">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd"
                    d="M6.293 4.293a1 1 0 011.414 0L10 6.586l2.293-2.293a1 1 0 111.414 1.414L11.414 8l2.293 2.293a1 1 0 11-1.414 1.414L10 9.414l-2.293 2.293a1 1 0 01-1.414-1.414L8.586 8 6.293 5.707a1 1 0 010-1.414z"
                    clip-rule="evenodd" />
            </svg>
        </button>
    </div>
@endif
