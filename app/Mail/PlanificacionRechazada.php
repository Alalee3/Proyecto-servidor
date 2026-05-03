<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class PlanificacionRechazada extends Mailable
{
    use Queueable, SerializesModels;

    public $profesor;
    public $planificacion;
    public $motivos;

    /**
     * Create a new message instance.
     */
    public function __construct($profesor, $planificacion, $motivos = [])
    {
        $this->profesor = $profesor;
        $this->planificacion = $planificacion;
        $this->motivos = $motivos;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Acción Requerida: Planificación Necesita Modificación',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.planificacion-rechazada',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
