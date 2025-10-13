package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Specialty;

import java.util.List;
import java.util.UUID;

public interface SpecialtyRepository {
    Specialty save(Specialty specialty);
    List<Specialty> findAll();
    Specialty findByNameAndDepartment(String name, UUID departmentId);
}

