package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Doctor;
import java.util.UUID;

public interface DoctorRepository {
    Doctor save(Doctor doctor);
    Doctor findByMatricule(String matricule);
    Doctor findByUserEmail(String email);
    Doctor findById(UUID id);
}
