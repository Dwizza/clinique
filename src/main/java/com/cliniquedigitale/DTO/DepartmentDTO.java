package com.cliniquedigitale.DTO;

import com.cliniquedigitale.entities.Specialty;

import java.util.List;
import java.util.UUID;

public class DepartmentDTO {

    private UUID id;

    private String name;
    private String description;
    private List<SpecialtyDTO> specialties;

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

    public List<SpecialtyDTO> getSpecialties() {
        return specialties;
    }

    public void setSpecialties(List<SpecialtyDTO> specialties) {
        this.specialties = specialties;
    }

}
