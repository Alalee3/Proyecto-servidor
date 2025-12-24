<?php

namespace App\Livewire\Planificacion; // Asegúrate de que este sea el namespace correcto para tu componente

use LivewireUI\Modal\ModalComponent;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule; // ¡Importante!
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Str;

class CreateInput extends ModalComponent // O CreateSingleFieldModal, según el nombre de tu componente
{
    public $type;           // Este es público y Livewire lo persistirá
    public $inputValue = '';
    public $inputLabel;     // Público, se puede persistir
    public $placeholder;    // Público, se puede persistir
    public $isRequired = false; // Público, se puede persistir

    // Estas propiedades NO necesitan ser públicas porque las construiremos
    // o derivaremos en cada solicitud.
    protected $tableName;
    protected $columnName;
    // Eliminamos 'protected $validationRules;' por completo,
    // ya que las reglas se generarán en el método rules().


    /**
     * Define el ancho máximo del modal.
     */
    public static function modalMaxWidth(): string
    {
        return 'sm';
    }

    /**
     * Monta el componente y establece sus propiedades iniciales basándose en el tipo.
     */
    public function mount(string $type)
    {
        $this->type = $type;

        // Establecemos las propiedades públicas para la interfaz de usuario.
        // Estas se persistirán automáticamente.
        switch ($this->type) {
            case 'recurso':
                $this->inputLabel = 'Nuevo Recurso';
                $this->placeholder = 'Ej: Pizarra, Proyector, Libro de texto';
                break;
            case 'estrategia':
                $this->inputLabel = 'Nueva Estrategia Pedagógica';
                $this->placeholder = 'Ej: Debate, Lluvia de ideas, Estudio de casos';
                break;
            case 'tecnica':
                $this->inputLabel = 'Nueva Técnica de Evaluación';
                $this->placeholder = 'Ej: Examen escrito, Exposición oral, Portafolio';
                break;
            case 'evaluacion':
                $this->inputLabel = 'Nueva Evaluacion';
                $this->placeholder = 'Ej: Examen escrito, Taller escrito, Conversatorio';
                break;
            case 'indicador':
                $this->inputLabel = 'Nuevo indicador de logros';
                $this->placeholder = 'Ej: el estudiante logró...';
                break;
            case 'bibliografia':
                $this->inputLabel = 'Nueva bibliografía';
                $this->placeholder = 'Bibliografía completa.';
                break;
            default:
                $this->dispatch('error', 'Tipo de elemento desconocido para la creación.');
                $this->closeModal();
                return;
        }

        // Para determinar si es requerido en la vista, podemos generar las reglas
        // temporalmente aquí o basarnos en el hecho de que siempre será requerido.
        // Para este caso, ya que 'required' siempre estará, podemos asumirlo.
        $this->isRequired = true; // Por ejemplo, si todos tus campos de creación son siempre requeridos
        // O si quieres ser más preciso, puedes hacer:
        // $tempRules = $this->getDynamicValidationRules();
        // $this->isRequired = in_array('required', (array) $tempRules['inputValue']);
    }

    /**
     * Método auxiliar para obtener dinámicamente las reglas de validación
     * y los nombres de tabla/columna.
     * Este método será llamado por rules() y save().
     * @return array Array con las reglas de validación y los nombres de tabla/columna
     */
    protected function getDynamicValidationConfig(): array
    {
        $config = [
            'tableName' => '',
            'columnName' => '',
            'rules' => []
        ];

        switch ($this->type) {
            case 'recurso':
                $config['tableName'] = 'recursos';
                $config['columnName'] = 'recurso';
                break;
            case 'estrategia':
                $config['tableName'] = 'estrategias_pedagogicas';
                $config['columnName'] = 'estrategia';
                break;
            case 'tecnica':
                $config['tableName'] = 'tecnicas';
                $config['columnName'] = 'tecnica';
                break;
            case 'evaluacion':
                $config['tableName'] = 'evaluaciones';
                $config['columnName'] = 'evaluacion';
                break;
            case 'indicador':
                $config['tableName'] = 'indicadores_logros';
                $config['columnName'] = 'indicador';
                break;
            case 'bibliografia':
                $config['tableName'] = 'bibliografias';
                $config['columnName'] = 'bibliografia';
                break;
            default:
                // Esto no debería suceder si mount() maneja bien los tipos desconocidos
                // Puedes lanzar una excepción o retornar un conjunto de reglas por defecto.
                return [
                    'tableName' => '',
                    'columnName' => '',
                    'rules' => ['inputValue' => ['required', 'string', 'max:255']]
                ];
        }

        $config['rules']['inputValue'] = [
            'required',
            'string',
            'min:3',
            'max:255',
            Rule::unique($config['tableName'], $config['columnName'])
        ];

        return $config;
    }


    /**
     * Define las reglas de validación para el componente.
     * Este método se llama en cada petición de validación (wire:model.live, save).
     */
    protected function rules()
    {
        $config = $this->getDynamicValidationConfig();
        return $config['rules'];
    }

    /**
     * Mensajes de validación genéricos para todos los tipos de input.
     */
    public function messages()
    {
        return [
            'inputValue.required' => 'Este campo es obligatorio.',
            'inputValue.string'   => 'El valor debe ser una cadena de texto.',
            'inputValue.min'      => 'Debe tener al menos :min caracteres.',
            'inputValue.max'      => 'No puede exceder de :max caracteres.',
            'inputValue.unique'   => 'Este valor ya existe. Por favor, ingrese uno diferente.',
        ];
    }

    /**
     * Validación en tiempo real para el campo de entrada.
     */
    public function updated($propertyName)
    {
        if ($propertyName === 'inputValue') {
            try {
                $this->validateOnly($propertyName);
            } catch (ValidationException $e) {
                // Livewire maneja la visualización del error
            }
        }
    }

    /**
     * Guarda el nuevo valor en la base de datos.
     */
    public function save()
    {
        // Primero, validamos (esto llama a rules() y, por lo tanto, a getDynamicValidationConfig())
        $this->validate();

        // Obtenemos de nuevo la configuración para saber qué tabla/columna usar al guardar
        $config = $this->getDynamicValidationConfig();
        $tableName = $config['tableName'];
        $columnName = $config['columnName'];

        // Aseguramos que tengamos un tableName y columnName válidos antes de proceder
        if (empty($tableName) || empty($columnName)) {
            $this->dispatch('error', 'Error al determinar la configuración de la base de datos para guardar.');
            $this->closeModal();
            return;
        }

        try {
            $dataToInsert = [
                $columnName => $this->inputValue,
            ];

            DB::table($tableName)->insert($dataToInsert);

            $successMessage = '¡Nuevo ' . Str::lower($this->inputLabel) . ' creado exitosamente!';

            // Emite un evento para que el componente padre pueda recargar sus listas
            $this->dispatch('itemCreated', [
                'tableName' => $tableName,
                'columnName' => $columnName,
                'newValue' => $this->inputValue
            ]);

            // Despacha el evento 'mostrar-mensaje' con el mismo texto
            $data = ['tipo' => 'exitoso', 'mensaje' => $successMessage];
            $this->dispatch('mostrar-mensaje', $data); // <--- Aquí pasas el mensaje ya construido

            $this->reset('inputValue');
        } catch (ValidationException $e) {
            // Re-lanzar para que Livewire maneje los errores de validación estándar
            throw $e;
        } catch (\Exception $e) {
            $data = ['tipo' => 'error', 'mensaje' => 'Error intentelo de nuevo'];
            $this->dispatch('mostrar-mensaje', $data);
        }
    }

    public function render()
    {
        return view('livewire.planificacion.create-input'); // Asegúrate que este sea el nombre correcto de tu vista Blade
    }

    public static function closeModalOnEscape(): bool
    {
        return true;
    }

    public static function closeModalOnClickAway(): bool
    {
        return false;
    }
}
