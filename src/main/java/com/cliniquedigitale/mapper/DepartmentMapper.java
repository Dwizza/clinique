package com.cliniquedigitale.mapper;

import com.cliniquedigitale.DTO.DepartmentDTO;
import com.cliniquedigitale.entities.Department;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class DepartmentMapper {

    public DepartmentDTO toDTO(Department entity) {
        if (entity == null) return null;

        DepartmentDTO dto = new DepartmentDTO();
        dto.setId(entity.getId());
        dto.setName(entity.getName());
        dto.setDescription(entity.getDescription());
        return dto;
    }

    public Department toEntity(DepartmentDTO dto) {
        if (dto == null) return null;

        Department entity = new Department();
        entity.setId(dto.getId()); // يمكن تهملها فحالة create جديد
        entity.setName(dto.getName());
        entity.setDescription(dto.getDescription());
        return entity;
    }

    public List<DepartmentDTO> toDTOList(List<Department> entities) {
        if (entities == null || entities.isEmpty()) return List.of();

        return entities.stream()
                .map(this::toDTO)
                .collect(Collectors.toList());
    }
}
