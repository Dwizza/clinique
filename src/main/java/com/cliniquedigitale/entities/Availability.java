package com.cliniquedigitale.entities;

import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.Enums.StatutDispo;
import jakarta.persistence.*;
import java.time.LocalTime;
import java.util.UUID;

@Entity
@Table(name = "availability")
public class Availability {

    @Id
    @GeneratedValue
    private UUID id;

    @Enumerated(EnumType.STRING)
    private Jour jour;

    private LocalTime heureDebut;
    private LocalTime heureFin;

    @Enumerated(EnumType.STRING)
    private StatutDispo statut;

    private boolean valide = true;

    @ManyToOne
    @JoinColumn(name = "doctor_id")
    private Doctor doctor;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public Jour getJour() {
        return jour;
    }

    public void setJour(Jour jour) {
        this.jour = jour;
    }

    public LocalTime getHeureDebut() {
        return heureDebut;
    }

    public void setHeureDebut(LocalTime heureDebut) {
        this.heureDebut = heureDebut;
    }

    public LocalTime getHeureFin() {
        return heureFin;
    }

    public void setHeureFin(LocalTime heureFin) {
        this.heureFin = heureFin;
    }

    public StatutDispo getStatut() {
        return statut;
    }

    public void setStatut(StatutDispo statut) {
        this.statut = statut;
    }

    public boolean isValide() {
        return valide;
    }

    public void setValide(boolean valide) {
        this.valide = valide;
    }

    public Doctor getDoctor() {
        return doctor;
    }

    public void setDoctor(Doctor doctor) {
        this.doctor = doctor;
    }
}
