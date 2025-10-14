package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.SpecialtyDTO;
import com.cliniquedigitale.entities.Department;
import com.cliniquedigitale.entities.Specialty;
import com.cliniquedigitale.repository.Impl.DepartmentRepositoryImpl;
import com.cliniquedigitale.repository.Impl.SpecialtyRepositoryImpl;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@ApplicationScoped
public class SpecialtyService {

    @Inject
    private SpecialtyRepositoryImpl specialtyRepository;

    @Inject
    private DepartmentRepositoryImpl departmentRepository;

    public SpecialtyDTO create(SpecialtyDTO dto){
        if (dto.getDepartmentId() == null) {
            throw new IllegalArgumentException("Département requis");
        }
        Department dep = departmentRepository.findById(dto.getDepartmentId());
        if (dep == null) {
            throw new IllegalArgumentException("Département introuvable");
        }
        if (dto.getName() == null || dto.getName().isBlank()) {
            throw new IllegalArgumentException("Nom requis");
        }
        if (specialtyRepository.findByNameAndDepartment(dto.getName(), dto.getDepartmentId()) != null) {
            throw new IllegalArgumentException("Nom déjà utilisé dans ce département");
        }
        Specialty s = new Specialty();
        s.setName(dto.getName());
        s.setDescription(dto.getDescription());
        s.setDepartment(dep);
        Specialty saved = specialtyRepository.save(s);
        SpecialtyDTO out = new SpecialtyDTO();
        out.setId(saved.getId());
        out.setName(saved.getName());
        out.setDescription(saved.getDescription());
        out.setDepartmentId(dep.getId());
        out.setDepartmentName(dep.getName());
        return out;
    }

    public List<Specialty> getAll(){
        return specialtyRepository.findAll();
    }
}

