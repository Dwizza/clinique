package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Doctor;

public interface DoctorRepository {
    Doctor save(Doctor doctor);
    Doctor findByMatricule(String matricule);
}
