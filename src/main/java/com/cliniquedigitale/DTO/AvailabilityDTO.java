package com.cliniquedigitale.DTO;

import com.cliniquedigitale.Enums.Jour;
import com.cliniquedigitale.Enums.StatutDispo;

import java.time.LocalTime;
import java.util.UUID;

public class AvailabilityDTO {
    private UUID id;
    private Jour jour;
    private LocalTime heureDebut;
    private LocalTime heureFin;
    private StatutDispo statut;

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
}

