package com.cliniquedigitale.mapper;

import com.cliniquedigitale.DTO.DoctorDTO;
import com.cliniquedigitale.entities.Doctor;
import com.cliniquedigitale.entities.Specialty;
import com.cliniquedigitale.entities.User;
import jakarta.enterprise.context.ApplicationScoped;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class DoctorMapper {

    // Entity → DTO
    public DoctorDTO toDTO(Doctor entity) {
        if (entity == null) return null;

        DoctorDTO dto = new DoctorDTO();
        dto.setId(entity.getId());
        dto.setMatricule(entity.getMatricule());
        dto.setTitre(entity.getTitre());

        Specialty specialty = entity.getSpecialite();
        if (specialty != null) {
            dto.setSpecialtyId(specialty.getId());
            dto.setSpecialtyName(specialty.getName());
        }

        User user = entity.getUser();
        if (user != null) {
            dto.setUserId(user.getId());
            dto.setUserFullName(user.getName());
            dto.setUserEmail(user.getEmail());
        }

        return dto;
    }

    // DTO → Entity
    public Doctor toEntity(DoctorDTO dto, Specialty specialty, User user) {
        if (dto == null) return null;

        Doctor entity = new Doctor();
        entity.setId(dto.getId());
        entity.setMatricule(dto.getMatricule());
        entity.setTitre(dto.getTitre());
        entity.setSpecialite(specialty);
        entity.setUser(user);

        return entity;
    }

    // تحويل List<Doctor> إلى List<DoctorDTO>
    public List<DoctorDTO> toDTOList(List<Doctor> doctors) {
        if (doctors == null || doctors.isEmpty()) return List.of();
        return doctors.stream().map(this::toDTO).collect(Collectors.toList());
    }
}
