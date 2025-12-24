<?php

namespace App\Livewire\Forms;

use App\Models\User;
use Illuminate\Auth\Events\Lockout;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;
use Livewire\Attributes\Validate;
use Livewire\Form;

class LoginForm extends Form
{
    #[Validate('required|string|email')]
    public string $email = '';

    #[Validate('required|string')]
    public string $password = '';

    #[Validate('boolean')]
    public bool $remember = false;

    /**
     * Attempt to authenticate the request's credentials.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function authenticate(): void
    {
        $this->ensureIsNotRateLimited();

        // 1. Obtener el usuario por email ANTES de intentar autenticar con la contraseña
        // para poder verificar su estatus.
        $user = User::where('email', $this->email)->first();

        // Si el usuario no existe, lanzar la excepción genérica de credenciales fallidas.
        // Esto evita "enumeración de usuarios" y es lo que Fortify hace por defecto.
        if (!$user) {
            RateLimiter::hit($this->throttleKey()); // Contabilizar como intento fallido
            throw ValidationException::withMessages([
                'form.email' => trans('auth.failed'),
            ]);
        }

        // 2. Verificar el estatus del usuario ANTES de intentar la autenticación de contraseña.
        // Si el estatus es '2' (suspendido/denegado), lanzamos la excepción específica.
        if ($user->estatus === '2') {
            RateLimiter::hit($this->throttleKey()); // Contabilizar como intento fallido
            throw ValidationException::withMessages([
                'form.email' => 'Tu cuenta ha sido deshabilitada o suspendida.', // Mensaje específico para el usuario
            ]);
        }

        // 3. Verificar si el estatus es '3' (inactivo) o cualquier otro estatus no permitido
        if ($user->estatus === '3') {
            RateLimiter::hit($this->throttleKey()); // Contabilizar como intento fallido
            throw ValidationException::withMessages([
                'form.email' => 'Tu cuenta está inactiva. Por favor, contacta al soporte.',
            ]);
        }

        if (! Auth::attempt($this->only(['email', 'password']), $this->remember)) {
            RateLimiter::hit($this->throttleKey());

            throw ValidationException::withMessages([
                'form.email' => trans('auth.failed'),
            ]);
        }

        RateLimiter::clear($this->throttleKey());
    }

    /**
     * Ensure the authentication request is not rate limited.
     */
    protected function ensureIsNotRateLimited(): void
    {
        if (! RateLimiter::tooManyAttempts($this->throttleKey(), 5)) {
            return;
        }

        event(new Lockout(request()));

        $seconds = RateLimiter::availableIn($this->throttleKey());

        throw ValidationException::withMessages([
            'form.email' => trans('auth.throttle', [
                'seconds' => $seconds,
                'minutes' => ceil($seconds / 60),
            ]),
        ]);
    }

    /**
     * Get the authentication rate limiting throttle key.
     */
    protected function throttleKey(): string
    {
        return Str::transliterate(Str::lower($this->email) . '|' . request()->ip());
    }
}
