package com.cliniquedigitale.entities;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "patients")
public class Patient extends User{

    @Id
    @GeneratedValue
    private UUID id;

    @Column(unique = true, nullable = false)
    private String cin;

    private LocalDate naissance;
    private String sexe;
    private String adresse;
    private String telephone;
    private String sang;

    @OneToOne
    @JoinColumn(name = "user_id", unique = true)
    private User user;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getCin() {
        return cin;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public LocalDate getNaissance() {
        return naissance;
    }

    public void setNaissance(LocalDate naissance) {
        this.naissance = naissance;
    }

    public String getSexe() {
        return sexe;
    }

    public void setSexe(String sexe) {
        this.sexe = sexe;
    }

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getSang() {
        return sang;
    }

    public void setSang(String sang) {
        this.sang = sang;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
