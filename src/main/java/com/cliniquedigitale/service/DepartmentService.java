package com.cliniquedigitale.service;

import com.cliniquedigitale.DTO.DepartmentDTO;
import com.cliniquedigitale.entities.Department;
import com.cliniquedigitale.mapper.DepartmentMapper;
import com.cliniquedigitale.repository.Impl.DepartmentRepositoryImpl;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.UUID;

@ApplicationScoped
public class DepartmentService {

    @Inject
    private DepartmentRepositoryImpl departmentRepository;

    @Inject
    private DepartmentMapper departmentMapper;

    public DepartmentDTO create(DepartmentDTO depDTO){
        Department dep = departmentRepository.findDepartment(depDTO.getName().toUpperCase());
        if (dep != null) {
            throw new IllegalArgumentException("Name déjà utilisé !");
        }

        Department department = departmentMapper.toEntity(depDTO);

        Department departmentEntity = departmentRepository.save(department);

        if(departmentEntity == null) {
            throw new IllegalArgumentException("Department non sauvgarde");
        }

        return departmentMapper.toDTO(departmentEntity);
    }

    public List<DepartmentDTO> getAll(){
        List<Department> entities = departmentRepository.findAll();
        return departmentMapper.toDTOList(entities);
    }


    public DepartmentDTO getById(UUID id){
        Department entity = departmentRepository.findById(id);
        return departmentMapper.toDTO(entity);
    }


    public DepartmentDTO update(DepartmentDTO depDTO){
        if (depDTO.getId() == null) {
            throw new IllegalArgumentException("Id manquant");
        }
        Department current = departmentRepository.findById(depDTO.getId());
        if (current == null) {
            throw new IllegalArgumentException("Department introuvable");
        }

        if (depDTO.getName() != null && !depDTO.getName().equalsIgnoreCase(current.getName())){
            Department exists = departmentRepository.findDepartment(depDTO.getName());
            if (exists != null) {
                throw new IllegalArgumentException("Name déjà utilisé !");
            }
        }
        current.setName(depDTO.getName());
        current.setDescription(depDTO.getDescription());
        Department updated = departmentRepository.update(current);
        return departmentMapper.toDTO(updated);
    }

    public boolean delete(UUID id){
        if (id == null) {
            throw new IllegalArgumentException("Id manquant");
        }
        try {
            return departmentRepository.deleteById(id);
        } catch (Exception e) {
            // Contrainte d'intégrité (FK sur spécialités, etc.)
            throw new IllegalStateException("Suppression impossible: des éléments y sont rattachés.");
        }
    }
}
