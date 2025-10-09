package com.cliniquedigitale.entities;

import com.cliniquedigitale.Enums.StatutAppointment;
import com.cliniquedigitale.Enums.TypeAppointment;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Entity
@Table(name = "appointments")
public class Appointment {

    @Id
    @GeneratedValue
    private UUID id;

    private LocalDate date;
    private LocalTime hour;

    @Enumerated(EnumType.STRING)
    private StatutAppointment statut = StatutAppointment.PLANNED;

    @Enumerated(EnumType.STRING)
    private TypeAppointment type;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public LocalTime getHour() {
        return hour;
    }

    public void setHour(LocalTime hour) {
        this.hour = hour;
    }

    public StatutAppointment getStatut() {
        return statut;
    }

    public void setStatut(StatutAppointment statut) {
        this.statut = statut;
    }

    public TypeAppointment getType() {
        return type;
    }

    public void setType(TypeAppointment type) {
        this.type = type;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }
}
