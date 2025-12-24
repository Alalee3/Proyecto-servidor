<button {{ $attributes->merge([
    'type' => 'submit', 
    'class' => 'inline-flex font-semibold items-center px-5 py-2.5 bg-blue-600 dark:bg-blue-600 border border-transparent rounded-lg font-medium text-sm text-white uppercase tracking-widest hover:bg-blue-700 dark:hover:bg-blue-700 focus:outline-none transition ease-in-out duration-150 disabled:bg-blue-800 dark:disabled:bg-blue-800 disabled:opacity-75 disabled:cursor-not-allowed'
]) }}>
    {{ $slot }}
</button> 