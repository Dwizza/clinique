package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Doctor;
import java.util.List;
import java.util.UUID;

public interface DoctorRepository {
    Doctor save(Doctor doctor);
    Doctor findByMatricule(String matricule);
    Doctor findByUserEmail(String email);
    Doctor findById(UUID id);
    List<Doctor> searchDoctors(String searchTerm);
    List<Doctor> findAll();
    List<Doctor> findBySpeciality(UUID specialityId);
}
