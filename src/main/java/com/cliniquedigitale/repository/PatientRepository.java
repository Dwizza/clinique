package com.cliniquedigitale.repository;

import com.cliniquedigitale.entities.Patient;
import java.util.List;

public interface PatientRepository {
    Patient save(Patient patient);
    Patient findByCin(String cin);
    Patient findByUserEmail(String email);
    List<Patient> findAll();
}
