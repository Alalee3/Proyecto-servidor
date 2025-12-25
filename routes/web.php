<?php

use App\Livewire\Planificacion\CreatePlanificacion;
use App\Livewire\Planificacion\ListPlanificacion;


use App\Livewire\Pnf\CreatePnf;
use App\Livewire\Pnf\UpdatePnf;
use App\Livewire\Pnf\ShowPnf;
use App\Livewire\Pnf\ListPnf;

use App\Livewire\Contenido\CreateContenido;
use App\Livewire\Contenido\ListContenido;
use App\Livewire\Contenido\UpdateContenido;
use App\Livewire\Contenido\ShowContenido;

use App\Livewire\Tema\CreateTema;
use App\Livewire\Tema\ListTema;
use App\Livewire\Tema\UpdateTema;
use App\Livewire\Tema\ShowTema;

use App\Livewire\Usuario\CreateUsuario;
use App\Livewire\Usuario\ListUsuario;

use App\Livewire\IndicadorLogro\CreateIndicadorLogro;
use App\Livewire\IndicadorLogro\ListIndicadorLogro;
use App\Livewire\IndicadorLogro\UpdateIndicadorLogro;
use App\Livewire\IndicadorLogro\ShowIndicadorLogro;

use App\Livewire\Bibliografia\CreateBibliografia;
use App\Livewire\Bibliografia\UpdateBibliografia;
use App\Livewire\Bibliografia\ShowBibliografia;
use App\Livewire\Bibliografia\ListBibliografia;

use App\Livewire\Recurso\CreateRecurso;
use App\Livewire\Recurso\UpdateRecurso;
use App\Livewire\Recurso\ShowRecurso;
use App\Livewire\Recurso\ListRecurso;

use App\Livewire\Estrategia\CreateEstrategia;
use App\Livewire\Estrategia\UpdateEstrategia;
use App\Livewire\Estrategia\ShowEstrategia;
use App\Livewire\Estrategia\ListEstrategia;

use App\Livewire\Tecnica\CreateTecnica;
use App\Livewire\Tecnica\UpdateTecnica;
use App\Livewire\Tecnica\ShowTecnica;
use App\Livewire\Tecnica\ListTecnica;

use App\Livewire\Evaluacion\CreateEvaluacion;
use App\Livewire\Evaluacion\UpdateEvaluacion;
use App\Livewire\Evaluacion\ShowEvaluacion;
use App\Livewire\Evaluacion\ListEvaluacion;

use Illuminate\Support\Facades\Route;

Route::view('/', 'welcome');

Route::view('dashboard', 'dashboard')
    ->middleware(['auth', 'verified'])
    ->name('dashboard');

Route::view('profile', 'profile')
    ->middleware(['auth'])
    ->name('profile');

Route::middleware(['auth', 'role:1'])->group(function () {
    Route::get('pnf/list', ListPnf::class)->name('pnf/listar');
    Route::get('pnf/create', CreatePnf::class)->name('pnf/crear');
    Route::get('pnf/update/{id}', UpdatePnf::class)->name('pnf/update');
    Route::get('pnf/show/{id}', ShowPnf::class)->name('pnf/show');

    Route::get('contenido/list', ListContenido::class)->name('contenido/listar');
    Route::get('contenido/create', CreateContenido::class)->name('contenido/crear');
    Route::get('contenido/update/{id}', UpdateContenido::class)->name('contenido/update');
    Route::get('contenido/show/{id}', ShowContenido::class)->name('contenido/show');

    Route::get('tema/list', ListTema::class)->name('tema/listar');
    Route::get('tema/create', CreateTema::class)->name('tema/crear');
    Route::get('tema/update/{id}', UpdateTema::class)->name('tema/update');
    Route::get('tema/show/{id}', ShowTema::class)->name('tema/show');

    Route::get('usuarios/create', CreateUsuario::class)->name('usuarios/crear');
    Route::get('usuarios/list', ListUsuario::class)->name('usuarios/listar');

    Route::get('planificacion/list', ListPlanificacion::class)->name('planificacion/listar');

    Route::get('indicador-logro/list', ListIndicadorLogro::class)->name('indicador-logro/listar');
    Route::get('indicador-logro/create', CreateIndicadorLogro::class)->name('indicador-logro/crear');
    Route::get('indicador-logro/update/{id}', UpdateIndicadorLogro::class)->name('indicador-logro/update');
    Route::get('indicador-logro/show/{id}', ShowIndicadorLogro::class)->name('indicador-logro/show');

    Route::get('bibliografia/list', ListBibliografia::class)->name('bibliografia/listar');
    Route::get('bibliografia/create', CreateBibliografia::class)->name('bibliografia/crear');
    Route::get('bibliografia/update/{id}', UpdateBibliografia::class)->name('bibliografia/update');
    Route::get('bibliografia/show/{id}', ShowBibliografia::class)->name('bibliografia/show');

    // Rutas para Recursos
    Route::get('recurso/list', ListRecurso::class)->name('recurso/listar');
    Route::get('recurso/create', CreateRecurso::class)->name('recurso/crear');
    Route::get('recurso/update/{id}', UpdateRecurso::class)->name('recurso/update');
    Route::get('recurso/show/{id}', ShowRecurso::class)->name('recurso/show');

    // Rutas para Estrategias Pedagógicas
    Route::get('estrategia/list', ListEstrategia::class)->name('estrategia/listar');
    Route::get('estrategia/create', CreateEstrategia::class)->name('estrategia/crear');
    Route::get('estrategia/update/{id}', UpdateEstrategia::class)->name('estrategia/update');
    Route::get('estrategia/show/{id}', ShowEstrategia::class)->name('estrategia/show');

    // Rutas para Técnicas de Evaluación
    Route::get('tecnica/list', ListTecnica::class)->name('tecnica/listar');
    Route::get('tecnica/create', CreateTecnica::class)->name('tecnica/crear');
    Route::get('tecnica/update/{id}', UpdateTecnica::class)->name('tecnica/update');
    Route::get('tecnica/show/{id}', ShowTecnica::class)->name('tecnica/show');

    // Rutas para Evaluaciones
    Route::get('evaluacion/list', ListEvaluacion::class)->name('evaluacion/listar');
    Route::get('evaluacion/create', CreateEvaluacion::class)->name('evaluacion/crear');
    Route::get('evaluacion/update/{id}', UpdateEvaluacion::class)->name('evaluacion/update');
    Route::get('evaluacion/show/{id}', ShowEvaluacion::class)->name('evaluacion/show');
});

Route::middleware(['auth'])->group(function () { });

Route::middleware(['auth', 'role:1|2'])->group(function () {
    Route::get('planificacion/create', CreatePlanificacion::class)->name('planificacion/crear');

    Route::get('planificacion/update/{planificacionId}', \App\Livewire\Planificacion\UpdatePlanificacion::class)->name('planificaciones.update');
    Route::get('planificacion/show/{planificacionId}', \App\Livewire\Planificacion\ShowPlanificacion::class)->name('planificacion/show');
});

require __DIR__ . '/auth.php';
