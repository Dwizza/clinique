package com.cliniquedigitale.DTO;

import java.util.UUID;

public class DoctorDTO {

    private UUID id;
    private String matricule;
    private String titre;
    private UUID specialtyId;
    private String specialtyName;
    private UUID userId;
    private String userFullName;
    private String userEmail;

    public DoctorDTO() {}

    public DoctorDTO(UUID id, String matricule, String titre,
                     UUID specialtyId, String specialtyName,
                     UUID userId, String userFullName, String userEmail) {
        this.id = id;
        this.matricule = matricule;
        this.titre = titre;
        this.specialtyId = specialtyId;
        this.specialtyName = specialtyName;
        this.userId = userId;
        this.userFullName = userFullName;
        this.userEmail = userEmail;
    }

    // Getters & Setters
    public UUID getId() { return id; }
    public void setId(UUID id) { this.id = id; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public UUID getSpecialtyId() { return specialtyId; }
    public void setSpecialtyId(UUID specialtyId) { this.specialtyId = specialtyId; }

    public String getSpecialtyName() { return specialtyName; }
    public void setSpecialtyName(String specialtyName) { this.specialtyName = specialtyName; }

    public UUID getUserId() { return userId; }
    public void setUserId(UUID userId) { this.userId = userId; }

    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
}
