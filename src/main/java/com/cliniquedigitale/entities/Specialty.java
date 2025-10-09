package com.cliniquedigitale.entities;

import jakarta.persistence.*;
import java.util.UUID;
import java.util.List;

@Entity
@Table(name = "specialties")
public class Specialty {

    @Id
    @GeneratedValue
    private UUID id;

    private String name;
    private String description;

    @ManyToOne
    @JoinColumn(name = "department_id")
    private Department department;

    @OneToMany(mappedBy = "specialite")
    private List<Doctor> doctors;

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public List<Doctor> getDoctors() {
        return doctors;
    }

    public void setDoctors(List<Doctor> doctors) {
        this.doctors = doctors;
    }
}
