<?php

namespace App\Livewire\Planificacion;

use Livewire\Component;
use LivewireUI\Modal\ModalComponent;
use App\Repositories\Planificacion\PlanificacionIndexRepo;
use App\Repositories\Planificacion\PlanificacionViewRepo;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Gate; // Importa Gate para la verificación de permisos
use Illuminate\Support\Facades\Log;   // Importa Log para el manejo de errores

class ShowPlanificacion extends ModalComponent
{
    public $planificacionId;
    public $planificacion; // Aquí se almacenarán todos los detalles de la planificación y sus cortes

    // Array asociativo para almacenar los motivos de rechazo de cada corte.
    // La clave será el 'detalle_id' del corte y el valor el texto del motivo.
    public $motivosRechazoCortes = [];

    public $mostrarMotivoRechazoCorte = [];

    protected $planificacionIndexRepo;
    protected $planificacionViewRepo;

    public function __construct()
    {
        $this->planificacionIndexRepo = new PlanificacionIndexRepo();
        $this->planificacionViewRepo = new PlanificacionViewRepo();
    }

    /**
     * Se ejecuta al inicializar el componente.
     * Carga los detalles de la planificación y sus cortes.
     * @param int $planificacionId
     */
    public function mount($planificacionId)
    {
        $this->planificacionId = $planificacionId;
        $this->loadPlanificacionDetails();
    }

    /**
     * Método auxiliar para cargar o recargar los detalles completos de la planificación.
     * Asegura que los cortes sean objetos y precarga los motivos de rechazo existentes.
     */
    private function loadPlanificacionDetails()
    {
        $details = $this->planificacionViewRepo->getDetallesPlanificacion($this->planificacionId);

        if (!$details) {
            session()->flash('error', 'La planificación solicitada no fue encontrada.');
            $this->closeModal();
            return;
        }

        // Convertir el array de detalles de planificación en un objeto para facilitar el acceso
        $this->planificacion = (object) $details;

        // Aseguramos que la colección de cortes dentro de la planificación también sea de objetos
        // e inicializamos los motivos de rechazo si ya existen en la base de datos.
        $this->planificacion->cortes = collect($this->planificacion->cortes)->map(function ($corte) {
            $corte = (object) $corte; // Convertir cada corte a un objeto

            // Inicializar el motivo en el array con el último motivo de rechazo si existe,
            // o con una cadena vacía si no. Esto precargará el textarea.
            $this->motivosRechazoCortes[$corte->detalle_id] = $corte->ultimo_motivo_rechazo ?? '';

            return $corte;
        })->toArray();
    }

    /**
     * Aprueba la planificación completa y sus cortes asociados.
     * Requiere que el usuario tenga el rol de 'coordinador'.
     */
    public function aprobarPlanificacion()
    {
        // Verificar si el usuario tiene el permiso de coordinador
        if (!Gate::allows('is-coordinador')) {
            session()->flash('error', 'No tienes permisos para aprobar planificaciones.');
            return;
        }

        $success = $this->planificacionIndexRepo->aprobarPlanificacion($this->planificacionId);

        if ($success) {
            $this->closeModalWithEvents([
                'planificacionAprobada',
                'recargarPlanificaciones'
            ]);
            $data = ['tipo' => 'exitoso', 'color' => 'green', 'mensaje' => 'Planificación aprobada correctamente!.'];
            $this->dispatch('mostrar-mensaje', $data);
        } else {
            $data = ['tipo' => 'error', 'color' => 'red', 'mensaje' => 'La planificacion no pudo ser aprobada.'];
            $this->dispatch('mostrar-mensaje', $data);
        }
    }

    /**
     * Rechaza la planificación completa, procesando los motivos individuales
     * de los cortes que el coordinador haya especificado.
     * Los cortes que no tengan un motivo no serán afectados por esta acción.
     */
    public function rechazarPlanificacion()
    {
        if (!Gate::allows('is-coordinador')) {
            session()->flash('error', 'No tienes permisos para rechazar planificaciones.');
            return;
        }
        $cortesARechazar = [];
        foreach ($this->planificacion->cortes as $corte) {
            $motivo = trim($this->motivosRechazoCortes[$corte->detalle_id] ?? '');
            if (!empty($motivo)) {
                if (mb_strlen($motivo) < 10) {
                    session()->flash('error', "El motivo de rechazo para el Corte #{$corte->corte} debe tener al menos 10 caracteres.");
                    return;
                }
                $cortesARechazar[] = [
                    'detalle_id' => $corte->detalle_id,
                    'motivo' => $motivo,
                ];
            }
        }
        if (empty($cortesARechazar)) {
            $data = ['tipo' => 'error', 'color' => 'red', 'mensaje' => 'La planificacion no pudo ser rechazada sin un motivo.'];
            $this->dispatch('mostrar-mensaje', $data);
            return;
        }
        $success = $this->planificacionIndexRepo->rechazarPlanificacionConCortes(
            $this->planificacion->planificacion_id,
            $cortesARechazar
        );
        if ($success) {
            $this->closeModalWithEvents([
                'planificacionAprobada',
                'recargarPlanificaciones'
            ]);
            $data = ['tipo' => 'exitoso', 'color' => 'red', 'mensaje' => 'Planificación rechazada correctamente!.'];
            $this->dispatch('mostrar-mensaje', $data);
            $this->mount($this->planificacion->planificacion_id); // Refrescar datos
        } else {
            $data = ['tipo' => 'error', 'color' => 'red', 'mensaje' => 'La planificacion no pudo ser rechazada.'];
            $this->dispatch('mostrar-mensaje', $data);
        }
    }

    public function eliminarMotivoRechazo($detalleId)
    {
        if (!Gate::allows('is-coordinador')) {
            session()->flash('error', 'No tienes permisos para eliminar motivos de rechazo.');
            return;
        }
        if (method_exists($this->planificacionIndexRepo, 'eliminarMotivoRechazoPorCorte')) {
            $this->planificacionIndexRepo->eliminarMotivoRechazoPorCorte($detalleId);
        }
        $this->motivosRechazoCortes[$detalleId] = '';
        $this->mount($this->planificacion->planificacion_id); // Refrescar datos
    }

    public function mostrarTextareaMotivo($detalleId)
    {
        if (!Gate::allows('is-coordinador')) {
            session()->flash('error', 'No tienes permisos para rechazar planificaciones.');
            return;
        }
        $this->mostrarMotivoRechazoCorte[$detalleId] = true;
    }

    public function ocultarTextareaMotivo($detalleId)
    {
        if (isset($this->mostrarMotivoRechazoCorte[$detalleId])) {
            $this->mostrarMotivoRechazoCorte[$detalleId] = false;
        }
    }

    /**
     * Renderiza la vista del componente.
     */
    public function render()
    {
        // Determinar si se debe mostrar el botón "Rechazar Planificación".
        // Se muestra si la planificación no está en estado "Aprobado" (estatus 1).
        $mostrarBotonRechazarPlanificacion = ($this->planificacion->estatus ?? null) != 1;

        // Se puede añadir una lógica para estatus de texto si los tienes en la BD
        // O podrías tener un método helper para mapear estatus numéricos a texto legible.
        $estatusTexto = $this->mapEstatusToText($this->planificacion->estatus ?? null);
        foreach ($this->planificacion->cortes as $key => $corte) {
            $this->planificacion->cortes[$key]->estatus_texto = $this->mapEstatusToText($corte->estatus);
        }

        return view('livewire.planificacion.show-planificacion', [
            'mostrarBotonRechazarPlanificacion' => $mostrarBotonRechazarPlanificacion,
            'estatusTexto' => $estatusTexto,
        ]);
    }

    /**
     * Mapa simple para convertir los estatus numéricos a texto legible.
     * Puedes expandir esto o moverlo a un modelo/trait si es más complejo.
     * @param int|null $estatus
     * @return string
     */
    private function mapEstatusToText(?int $estatus): string
    {
        switch ($estatus) {
            case 1:
                return 'Aprobado';
            case 2:
                return 'Pendiente'; // O 'En Revisión' si 2 es ese estado inicial
            case 3:
                return 'Rechazado';
            default:
                return 'Desconocido';
        }
    }

    // --- Configuración del Modal ---

    /**
     * Define el ancho máximo del modal.
     */
    public static function modalMaxWidth(): string
    {
        return '4xl'; // Ajusta esto según tus necesidades (ej. 'xl', '2xl', '3xl', '5xl', '6xl', '7xl')
    }

    /**
     * Permite cerrar el modal presionando la tecla Escape.
     */
    public static function closeModalOnEscape(): bool
    {
        return true;
    }

    /**
     * Evita que el modal se cierre al hacer clic fuera de él.
     */
    public static function closeModalOnClickAway(): bool
    {
        return false;
    }
}
