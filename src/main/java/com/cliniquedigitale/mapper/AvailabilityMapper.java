package com.cliniquedigitale.mapper;

import com.cliniquedigitale.DTO.AvailabilityDTO;
import com.cliniquedigitale.entities.Availability;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.ArrayList;
import java.util.List;

@ApplicationScoped
public class AvailabilityMapper {
    public AvailabilityDTO toDTO(Availability entity) {
        if (entity == null) return null;
        AvailabilityDTO dto = new AvailabilityDTO();
        dto.setId(entity.getId());
        dto.setJour(entity.getJour());
        dto.setHeureDebut(entity.getHeureDebut());
        dto.setHeureFin(entity.getHeureFin());
        dto.setStatut(entity.getStatut());
        return dto;
    }

    public Availability toEntity(AvailabilityDTO dto) {
        if (dto == null) return null;
        Availability entity = new Availability();
        entity.setId(dto.getId());
        entity.setJour(dto.getJour());
        entity.setHeureDebut(dto.getHeureDebut());
        entity.setHeureFin(dto.getHeureFin());
        entity.setStatut(dto.getStatut());
        entity.setValide(true);
        return entity;
    }

    public List<AvailabilityDTO> toDTOList(List<Availability> entities) {
        if (entities == null || entities.isEmpty()) return List.of();
        List<AvailabilityDTO> list = new ArrayList<>();
        for (Availability a : entities) list.add(toDTO(a));
        return list;
    }
}

