<button {{ $attributes->merge([
    'type' => 'submit', 
    'class' => 'inline-flex items-center px-5 py-2.5 bg-[#f0f0f0] border-2 border-[#767676] rounded-md font-bold text-sm text-black uppercase tracking-widest hover:bg-[#e5e5e5] focus:outline-none transition ease-in-out duration-150 disabled:opacity-50 disabled:cursor-not-allowed shadow-sm'
]) }}>
    {{ $slot }}
</button> 