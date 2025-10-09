package com.cliniquedigitale.entities;


import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "medical_notes")
public class MedicalNote {

    @Id
    @GeneratedValue
    private UUID id;

    @Column(nullable = false)
    private String content;

    private LocalDateTime dateCreation = LocalDateTime.now();

    @OneToOne
    @JoinColumn(name = "appointment_id", unique = true)
    private Appointment appointment;

    @ManyToOne
    @JoinColumn(name = "auteur_id")
    private Doctor auteur;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDateTime getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDateTime dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public Doctor getAuteur() {
        return auteur;
    }

    public void setAuteur(Doctor auteur) {
        this.auteur = auteur;
    }
}

