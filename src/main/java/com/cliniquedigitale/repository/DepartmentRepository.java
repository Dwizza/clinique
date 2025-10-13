package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Department;

import java.util.List;
import java.util.UUID;

public interface DepartmentRepository {
    Department findDepartment(String name);
    Department save(Department department);
    List<Department> findAll();
    Department findById(UUID id);
    Department update(Department department);
    boolean deleteById(UUID id);
}
