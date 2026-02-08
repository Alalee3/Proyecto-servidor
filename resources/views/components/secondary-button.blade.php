<button {{ $attributes->merge([
    'type' => 'button', 
    'class' => 'inline-flex items-center px-4 py-2 bg-[#f0f0f0] border-2 border-[#767676] rounded-md font-bold text-xs text-black uppercase tracking-widest hover:bg-[#e5e5e5] focus:outline-none transition ease-in-out duration-150 disabled:opacity-50 shadow-sm'
]) }}>
    {{ $slot }}
</button>
